class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes, id: :uuid do |t|
      t.references :client
      t.date       :date
      t.time       :start_time
      t.time       :end_time
      t.integer    :total_hours
      t.text       :service_description
      t.integer    :transportation_trips
      t.string     :location
      t.string     :interactions
      t.text       :support_provided
      t.text       :comments
      t.boolean    :incedent_reports_filed
      t.references :incedent_report

      t.timestamps
    end
  end
end
