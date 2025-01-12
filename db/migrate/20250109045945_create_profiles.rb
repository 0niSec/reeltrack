class CreateProfiles < ActiveRecord::Migration[8.0]

  def change
    create_table :profiles do |t|
      t.text :bio
      t.text :likes
      t.text :dislikes
      t.integer :age
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

end
