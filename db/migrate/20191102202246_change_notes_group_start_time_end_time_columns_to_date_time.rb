class ChangeNotesGroupStartTimeEndTimeColumnsToDateTime < ActiveRecord::Migration[5.1]
  def up
    remove_column :note_groups, :start_time
    remove_column :note_groups, :end_time
    add_column :note_groups, :start_time, :timestamp
    add_column :note_groups, :end_time, :timestamp
  end

  def down
    remove_column :note_groups, :start_time
    remove_column :note_groups, :end_time
    add_column :note_groups, :start_time, :time
    add_column :note_groups, :end_time, :time
  end
end
