class Note < ApplicationRecord
  audited

  belongs_to :note_group
  belongs_to :client
  # has_one    :incident_report, optional: true

  def total_hours
    offset = self.client.organization.utc_offset*3600
    s = (self.start_time + offset).strftime("%r")
    e = (self.end_time   + offset).strftime("%r")
    return (Time.parse(e) - Time.parse(s))/3600
  end

  def incident_report?
    return false
  end

  def sub_client
    args = ["CLIENT", self.client.to_s]
    self.service_description = self.service_description.gsub(*args)
    self.location = self.location.gsub(*args)
    self.interactions = self.interactions.gsub(*args)
    self.support_provided = self.support_provided.gsub(*args)
    self.comments = self.comments.gsub(*args)
    self.save
  end
end
