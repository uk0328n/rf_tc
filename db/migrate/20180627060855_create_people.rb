class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.integer :customer_id
      t.integer :advisor_id

      t.timestamps
    end
    add_index :people, :customer_id, :unique=>true
    add_index :people, :advisor_id, :unique=>true
  end
end
