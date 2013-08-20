class AddPayedColumnToCheckings < ActiveRecord::Migration
  def change
    add_column :checkings, :paid, :boolean, default: false
  end
end
