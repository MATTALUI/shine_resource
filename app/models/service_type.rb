class ServiceType < ApplicationRecord
  scope :for_org, ->(org_id){ where(organization_id: org_id) }
  scope :active, ->{ where(active: true) }

  def to_s
    return self.name
  end
end
