class AddNullToEvent < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :name, :string, null: false, default: ""
    change_column :events, :event_date, :date, null: false, default: ""
    change_column :events, :venue, :string, null: false, default: ""
    change_column :events, :capacity, :integer, null: false, default: 0
  end
end
