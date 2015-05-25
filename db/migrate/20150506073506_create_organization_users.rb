class CreateOrganizationUsers < ActiveRecord::Migration
  def change
    create_table :organization_users do |t|
      t.belongs_to :user
      t.belongs_to :organization
      t.boolean :is_admin
      t.timestamps
    end
  end
end
