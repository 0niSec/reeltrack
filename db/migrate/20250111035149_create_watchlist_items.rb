class CreateWatchlistItems < ActiveRecord::Migration[8.0]

  def change
    create_table :watchlist_items do |t|
      t.belongs_to :user
      t.belongs_to :watchable, polymorphic: true
      t.timestamps
    end
  end

end
