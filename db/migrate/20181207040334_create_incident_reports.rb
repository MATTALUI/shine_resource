class CreateIncidentReports < ActiveRecord::Migration[5.1]
  def change
    create_table :incident_reports do |t|
      t.string :note_id, index: true
      t.string :client_id, index: true
      t.string :caretaker_id, index: true
      t.text   :body

      t.timestamps
    end
  end
end
