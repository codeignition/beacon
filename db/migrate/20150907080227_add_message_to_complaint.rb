class AddMessageToComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :message, :string, default: ""
  end
end
