class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj

      t.timestamps
    end

    #index search
    add_index :companies, :id
  end
end
