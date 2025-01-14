class RemoveAvatarsFromActiveStorage < ActiveRecord::Migration[8.0]

  def up
    ActiveStorage::Attachment.where(name: "avatar", record_type: "User").destroy_all
    ActiveStorage::Blob.where.not(id: ActiveStorage::Attachment.select(:blob_id)).destroy_all
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
