class Profile < ApplicationRecord

  belongs_to :user

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
    attachable.variant :medium, resize_to_limit: [ 300, 300 ]
  end

  def avatar_url(size: 128)
    if avatar.attached?
      # Use the appropriate variant based on the size
      if size <= 128
        avatar.variant(:thumb)
      else
        avatar.variant(:medium)
      end
    else
      # Return a default avatar if no avatar is attached
      "https://ui-avatars.com/api/?name=#{URI.encode_www_form_component(user.username)}&size=#{size}&background=ef4444&color=fff"
    end
  end

end
