class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.integer :school_id
      t.string :major
      t.integer :gradyear
      t.text :aboutme
      t.timestamps
      t.has_attached_file :avatar
    end
  end

  def down
  end
end
