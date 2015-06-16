class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: Settings.user.role.admin
  end
end
