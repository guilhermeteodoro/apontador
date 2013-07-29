class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
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

      # mti
      # t.integer :personble_id
      # t.string :personable_type

      t.timestamps
    end

    #index search
    #add_index :people, [:id, :personable_id]
  end
end
