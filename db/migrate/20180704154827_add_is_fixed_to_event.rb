class AddIsFixedToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :is_fixed, :boolean
  end
end
