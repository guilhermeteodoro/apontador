class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.timestamp :checked_in_at
      t.timestamp :checked_out_at
      t.decimal :value, precision: 10, scale: 2
      t.integer :user_id
    end
  end
end
