class ModifyOrgAndComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :ip_address, :string
    add_column :organizations, :token, :string
    add_column :contacts, :organization_id, :integer
    add_column :escalation_rules, :organization_id, :integer
  end
end
