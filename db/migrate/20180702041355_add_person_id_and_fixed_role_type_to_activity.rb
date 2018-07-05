class AddPersonIdAndFixedRoleTypeToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :person_id, :integer
    add_column :activities, :fixed_role_type, :integer
  end
end
