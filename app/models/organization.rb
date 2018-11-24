class Organization < ApplicationRecord
  audited

  has_one  :organization_settings
  has_many :caretakers
  has_many :clients

  
  def to_s
    return self.name
  end
end
