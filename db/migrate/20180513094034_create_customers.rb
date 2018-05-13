class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :company
      t.string :position
      t.boolean :is_exective
      t.timestamps
    end
  end
end
