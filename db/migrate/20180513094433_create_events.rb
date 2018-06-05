class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :event_date
      t.string :venue
      t.integer :capacity
      t.integer :editor_code

      t.timestamps
    end
  end
end
