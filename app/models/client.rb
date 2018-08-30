class Client < ApplicationRecord
  attr_encrypted :addr1,        key: ENV["encryption_key"]
  attr_encrypted :addr2,        key: ENV["encryption_key"]
  attr_encrypted :dob,   key: ENV["encryption_key"]
  attr_encrypted :description,  key: ENV["encryption_key"]
  attr_encrypted :services_needed,       key: ENV["encryption_key"]
  attr_encrypted :ideal_providor,key: ENV["encryption_key"]
  attr_encrypted :important_to_me,   key: ENV["encryption_key"]
  attr_encrypted :important_for_me,   key: ENV["encryption_key"]
  attr_encrypted :additional_info,   key: ENV["encryption_key"]
  attr_encrypted :shine_services,   key: ENV["encryption_key"]
  attr_encrypted :photo_url,     key: ENV["encryption_key"]

  def to_s
    return [self.first_name, self.last_initial].compact.join(' ')
  end

  def parsed_dob
    return Date.parse(self.dob) rescue nil
  end

  def formatted_dob(format='%m/%d/%Y')
    return self.parsed_dob.strftime(format)
  end

  def address
    return[self.addr1, self.addr2,[self.town, self.state].compact.join(', ')].compact.join("\n")
  end
end
