class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.text :text
      t.references :user
      t.references :project
      t.timestamps
    end
  end
end
