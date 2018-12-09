class Note < ApplicationRecord
  audited

  belongs_to :note_group
  belongs_to :client
  # has_one    :incedent_report, optional: true
end
