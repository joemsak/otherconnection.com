class ChangeRecordIdToUuidOnActiveStorageAttachments < ActiveRecord::Migration[6.1]
  def up
    remove_column :active_storage_attachments, :record_id, :integer

    add_column :active_storage_attachments, :record_id, :uuid, null: false

    add_index :active_storage_attachments,
      %i[record_type record_id name blob_id],
      name: "index_active_storage_attachments_uniqueness",
      unique: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
