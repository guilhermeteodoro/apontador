class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :token
      t.timestamp :date
      t.boolean :concluded, default: false

      t.integer :user_id

      t.timestamps
    end
  end
end
