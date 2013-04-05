class CreateProjectsUsers < ActiveRecord::Migration
  def up
    create_table :projects_users do |t|
      t.references :project
      t.references :user
    end
    add_index(:projects_users, [:project_id, :user_id], :unique => true)
  end

  def down
  end
end
