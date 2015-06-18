class CreatePositionUsers < ActiveRecord::Migration
  def change
    create_table :position_users do |t|
      t.references :user, index: true
      t.references :position, index: true

      t.timestamps null: false
    end
    add_foreign_key :position_users, :users
    add_foreign_key :position_users, :positions
  end
end
