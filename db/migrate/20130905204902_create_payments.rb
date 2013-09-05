class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|

      t.string :token
      t.boolean :concluded, default: false

      t.integer :user_id

      t.timestamps
    end
  end
end
