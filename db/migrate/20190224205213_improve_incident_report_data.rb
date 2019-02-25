class ImproveIncidentReportData < ActiveRecord::Migration[5.1]
  def change
    rename_column :incident_reports, :body, :description

    change_table :incident_reports do |t|
      t.date :date
      t.string  :organization_id, index: true
      t.string  :codes, :location, :incident_number
      t.time    :start_time
      t.integer :duration
      t.boolean :observed_directly, :likely_to_reoccur, :hrc_review, :ap_review, :law_review, :critical, :followup_needed
      t.text    :preface, :action_taken, :alternative_action, :witnesses, :followup, :comments
    end


  end
end
