class CreateSchools < ActiveRecord::Migration
  def up
    create_table :schools do |t|
      t.string :name
      t.string :location
      t.string :uri
      t.timestamps
    end
  end

  def down
  end
end
