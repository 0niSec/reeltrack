class RemoveUsernameFromProfiles < ActiveRecord::Migration[8.0]
  def change
    remove_column :profiles, :username, :string
  end
end
