class CreateSkillUsers < ActiveRecord::Migration
  def change
    create_table :skill_users do |t|
      t.references :user, index: true
      t.references :skill
      t.string :level
      t.integer :year

      t.timestamps null: false
    end
  end
end
