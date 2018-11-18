class OrganizationSetting < ApplicationRecord
  audited
  
  belongs_to :organization
end
