class DropMisspelledReports < ActiveRecord::Migration[5.1]
  def change
    drop_table :incedent_reports
  end
end
