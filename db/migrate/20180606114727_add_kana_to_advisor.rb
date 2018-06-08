class AddKanaToAdvisor < ActiveRecord::Migration[5.1]
  def change
    add_column :advisors, :kana, :string, null: false, default: ""
    remove_index :advisors, :name
    change_column :advisors, :name, :string, null: false, default: ""
  end
end
