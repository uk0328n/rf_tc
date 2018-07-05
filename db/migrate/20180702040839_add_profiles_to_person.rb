class AddProfilesToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :role_type, :integer
    add_column :people, :rank, :integer
    add_column :people, :name, :string
    add_column :people, :kana, :string
    add_column :people, :company, :string
    add_column :people, :company_kana, :string
    add_column :people, :company_short_name, :string
    add_column :people, :position, :string
    add_column :people, :postal_code, :string
    add_column :people, :address, :string
    add_column :people, :tel, :string
    add_column :people, :fax, :string
    add_column :people, :email, :string
    add_column :people, :contact_person_name, :string
    add_column :people, :contact_postal_code, :string
    add_column :people, :contact_address, :string
    add_column :people, :contact_tel, :string
    add_column :people, :contact_fax, :string
    add_column :people, :contact_email, :string
    add_column :people, :editor_code, :string
  end
end
