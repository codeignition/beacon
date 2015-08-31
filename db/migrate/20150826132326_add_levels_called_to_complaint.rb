class AddLevelsCalledToComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :levels_called, :integer, default: 0
  end
end
