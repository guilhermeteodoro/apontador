class AddLatAndLngColumnsToCheckings < ActiveRecord::Migration
  def change
    add_column :checkings, :lat, :float
    add_column :checkings, :lng, :float
  end
end
