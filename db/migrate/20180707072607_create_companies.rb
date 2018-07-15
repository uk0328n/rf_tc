class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :kana
      t.string :short_name
      t.string :short_name_kana

      t.timestamps
    end
  end
end
