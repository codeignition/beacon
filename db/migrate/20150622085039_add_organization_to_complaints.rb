class AddOrganizationToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :organization_id, :integer
  end
end
