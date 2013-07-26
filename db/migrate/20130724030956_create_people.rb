class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.integer :cpf
      t.string :institution
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :phone
      t.boolean :admin

      t.timestamps
    end
  end
end
