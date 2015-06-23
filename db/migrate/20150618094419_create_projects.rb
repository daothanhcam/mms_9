class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :team, index: true
      t.string :name
      t.string :abbreviation

      t.timestamps null: false
    end
    add_foreign_key :projects, :teams
  end
end
