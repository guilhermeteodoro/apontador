class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :token
      t.timestamp :date
      t.boolean :concluded, default: false

      t.timestamps
    end
  end
end
