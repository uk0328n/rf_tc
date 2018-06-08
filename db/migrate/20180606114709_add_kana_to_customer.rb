class AddKanaToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :kana, :string, null: false, default: ""
    remove_index :customers, :name
    change_column :customers, :name, :string, null: false, default: ""
  end
end
