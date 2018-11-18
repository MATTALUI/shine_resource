class Client < ApplicationRecord
  audited

  belongs_to :organization

  attr_encrypted :addr1,            key: ENV["encryption_key"]
  attr_encrypted :addr2,            key: ENV["encryption_key"]
  attr_encrypted :dob,              key: ENV["encryption_key"]
  attr_encrypted :description,      key: ENV["encryption_key"]
  attr_encrypted :services_needed,  key: ENV["encryption_key"]
  attr_encrypted :ideal_provider,   key: ENV["encryption_key"]
  attr_encrypted :important_to_me,  key: ENV["encryption_key"]
  attr_encrypted :important_for_me, key: ENV["encryption_key"]
  attr_encrypted :additional_info,  key: ENV["encryption_key"]
  attr_encrypted :shine_services,   key: ENV["encryption_key"]
  attr_encrypted :photo_url,        key: ENV["encryption_key"]

  has_many :memos
  has_many :notes

  scope :with_org, ->(org_id) {where(organization_id: org_id)}
  scope :search,   ->(term){ where('lower(first_name) LIKE ?', "%#{term.downcase}%") }

  def to_s
    return [self.first_name, self.last_initial].compact.join(' ')
  end

  def parsed_dob
    return Date.parse(self.dob) rescue nil
  end

  def formatted_dob(format='%m/%d/%Y')
    return self.parsed_dob&.strftime(format)
  end

  def address
    return[self.addr1, self.addr2,[self.town, self.state].compact.join(', ')].compact.join("\n")
  end

  class << self
    def oldest
      return self.order(created_at: :asc).first
    end

    def most_recent
      return self.order(created_at: :desc).first
    end
  end
end
