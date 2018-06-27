class AddPersonIdToCustomerAndAdvisor < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :person_id, :integer
    add_column :advisors, :person_id, :integer
  end
end
