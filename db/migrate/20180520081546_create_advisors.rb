class CreateAdvisors < ActiveRecord::Migration[5.1]
  def change
    create_table :advisors do |t|
      t.string :name
      t.string :company
      t.string :company_short_name
      t.string :position
      t.string :postal_code
      t.string :address
      t.string :tel
      t.string :fax
      t.string :email
      t.string :contact_person_name
      t.string :contact_postal_code
      t.string :contact_address
      t.string :contact_tel
      t.string :contact_fax
      t.string :contact_email
      t.integer :editor_code
      t.boolean :is_disable

      t.timestamps
    end
    add_index :advisors, :name, :unique=>true
  end
end
