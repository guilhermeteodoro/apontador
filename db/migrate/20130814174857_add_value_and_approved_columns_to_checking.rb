class AddValueAndApprovedColumnsToChecking < ActiveRecord::Migration
  def change
    add_column :checkings, :value, :decimal, precision: 10, scale: 2
    add_column :checkings, :approved, :boolean
  end
end
