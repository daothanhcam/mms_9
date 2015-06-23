class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :project_users do |t|
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :project_users, :users
    add_foreign_key :project_users, :projects
  end
end
