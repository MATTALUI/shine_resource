class ChangeNotesStartTimeEndTimeColumnsToDateTime < ActiveRecord::Migration[5.1]
  def up
    remove_column :notes, :start_time
    remove_column :notes, :end_time
    add_column :notes, :start_time, :timestamp
    add_column :notes, :end_time, :timestamp
  end

  def down
    remove_column :notes, :start_time
    remove_column :notes, :end_time
    add_column :notes, :start_time, :time
    add_column :notes, :end_time, :time
  end
end
