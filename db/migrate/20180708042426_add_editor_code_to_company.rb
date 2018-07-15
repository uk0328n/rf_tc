class AddEditorCodeToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :editor_code, :integer
  end
end
