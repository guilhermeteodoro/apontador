class AddMtiColumnsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :as_person_id, :integer
    add_column :people, :as_person_type, :string
  end
end
