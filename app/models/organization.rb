class Organization < ApplicationRecord
  audited
  
  has_one  :organization_settings
  has_many :caretakers
  def to_s
    return self.name
  end
end
