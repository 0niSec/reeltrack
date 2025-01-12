class RemoveLikesAndDislikesFromProfiles < ActiveRecord::Migration[8.0]

  def change
    remove_column :profiles, :likes
    remove_column :profiles, :dislikes
  end

end
