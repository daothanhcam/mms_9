class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.datetime :time
      t.string :action
      t.string :user
      t.string :description

      t.timestamps null: false
    end
  end
end
