class RemoveUniquenessFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_index :activities, [:customer_id, :event_id]
    add_index :activities, [:customer_id, :event_id]
  end
end
