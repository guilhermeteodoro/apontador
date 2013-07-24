class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.integer :cpf
      t.string :address
      t.string :city
      t.string :phone
      t.boolean :admin

      t.timestamps
    end
  end
end
