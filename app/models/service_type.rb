class ServiceType < ApplicationRecord
  scope :for_org, ->(org_id){ where(organization_id: org_id) }
end
