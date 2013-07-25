class AddIntitutionColumnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :institution, :string
  end
end
