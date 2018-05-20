class CreateEventDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :event_details do |t|
      t.integer :event_id
      t.integer :advisor_id
      t.integer :attendance_type

      t.timestamps
    end
    add_index :event_details, [:advisor_id, :event_id], :unique=>true
    add_foreign_key :event_details, :advisors
    add_foreign_key :event_details, :events
  end
end
