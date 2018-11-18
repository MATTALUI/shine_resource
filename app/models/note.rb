class Note < ApplicationRecord
  audited

  belongs_to :note_group
  belongs_to :client
end
