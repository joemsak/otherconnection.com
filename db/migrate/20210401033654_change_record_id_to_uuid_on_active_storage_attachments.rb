class ChangeRecordIdToUuidOnActiveStorageAttachments < ActiveRecord::Migration[6.1]
  def up
    remove_column :active_storage_attachments, :record_id, :integer
    add_column :active_storage_attachments, :record_id, :uuid
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
