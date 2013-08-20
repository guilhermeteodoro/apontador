class AddHourValueColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :hour_value, :decimal, precision: 10, scale: 2
  end
end
