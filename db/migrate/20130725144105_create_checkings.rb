class CreateCheckings < ActiveRecord::Migration
  def change
    create_table :checkings do |t|
      t.timestamp :checked_in_at
      t.timestamp :checked_out_at
      t.decimal :hour_value, precision: 10, scale: 2
      t.integer :user_id
    end
  end
end
