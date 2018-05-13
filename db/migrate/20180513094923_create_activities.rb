class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.integer :customer_id
      t.integer :event_id
      t.integer :attendance

      t.timestamps
    end
  end
end
