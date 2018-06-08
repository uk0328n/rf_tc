class RemoveUniquenessFromEventDetails < ActiveRecord::Migration[5.1]
  def change
    remove_index :event_details, [:advisor_id, :event_id]
    add_index :event_details, [:advisor_id, :event_id]
  end
end
