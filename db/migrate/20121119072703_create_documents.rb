class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :description
      t.integer :project_id
      #t.integer :uploader_id
      t.integer :updater_id
      #t.timestamps
    end
  end
end
