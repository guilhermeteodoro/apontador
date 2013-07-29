class CreateManagerPeople < ActiveRecord::Migration
  def change
    create_table :manager_people do |t|
      t.string :institution
      t.integer :cnpj
    end
  end
end
