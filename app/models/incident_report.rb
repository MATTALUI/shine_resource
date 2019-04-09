class IncidentReport < ApplicationRecord
  audited
  belongs_to :note
end
