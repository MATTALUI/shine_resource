class AddGroupMiles < ActiveRecord::Migration[5.1]
  def change
    add_column :note_groups, :miles, :integer, default: 0
  end
end
