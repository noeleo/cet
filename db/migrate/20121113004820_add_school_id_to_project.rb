class AddSchoolIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :school_id, :integer
  end
end
