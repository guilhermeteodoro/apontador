class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :phone
      t.string :type
      t.boolean :manager
      t.integer :company_id

      t.timestamps
    end

    #index search
    add_index :users, :id
  end
end
