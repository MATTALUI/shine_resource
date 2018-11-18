class CreateIncedentReports < ActiveRecord::Migration[5.1]
  def change
    create_table :incedent_reports, id: :uuid do |t|
      t.string :note_id

      t.timestamps
    end
    add_index :incedent_reports, :note_id
  end
end
