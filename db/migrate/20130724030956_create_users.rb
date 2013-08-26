class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password
      t.integer :number
      t.string :street
      t.string :city
      t.float :latitude
      t.float :longitude
      t.decimal :hour_value, precision: 10, scale: 2
      t.boolean :manager, default: false
      t.integer :company_id

      t.timestamps
    end

    #index search
    add_index :users, :id
  end
end
