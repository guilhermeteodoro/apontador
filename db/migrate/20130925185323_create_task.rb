class CreateTask < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :hour_value, precision: 10, scale: 2
      t.string :duration
      t.string :status, default: "pending", null: false

      t.integer :company_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
