class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.integer :customer_id
      t.integer :event_id
      t.integer :attendance_type
      t.integer :editor_code

      t.timestamps
    end
    add_index :activities, [:customer_id, :event_id], :unique=>true
    add_foreign_key :activities, :customers
    add_foreign_key :activities, :events
  end
end
