class CreateTask < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
