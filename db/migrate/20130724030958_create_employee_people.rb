class CreateEmployeePeople < ActiveRecord::Migration
  def change
    create_table :employee_people do |t|
      t.integer :cpf
    end
  end
end
