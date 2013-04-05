class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :startTime
      t.datetime :endTime
      t.string :location
      t.references :school
      t.timestamps
    end
  end
end
