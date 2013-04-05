class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :creator_id
      t.timestamps
    end
  end

  def down
  end
end
