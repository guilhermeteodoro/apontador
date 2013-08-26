class CreateCheckings < ActiveRecord::Migration
  def change
    create_table :checkings do |t|
      t.timestamp :checked_in_at
      t.timestamp :checked_out_at
      t.boolean :approved, default: false
      t.boolean :paid, default: false
      t.decimal :hour_value, precision: 10, scale: 2
      t.decimal :value, precision: 10, scale: 2
      t.float :lat
      t.float :lng
      t.integer :user_id
    end
  end
end
