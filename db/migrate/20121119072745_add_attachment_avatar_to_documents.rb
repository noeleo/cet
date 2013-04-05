class AddAttachmentAvatarToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :documents, :avatar
  end
end
