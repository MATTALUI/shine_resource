class Note < ApplicationRecord
  audited

  belongs_to :note_group
  belongs_to :client
  # has_one    :incident_report, optional: true

  def total_hours
    s = self.start_time - ()
    e = self.end_time   - ()
    return (Time.parse() - Time.parse())/3600
  end

  def incedent_report?
    return false
  end
end
