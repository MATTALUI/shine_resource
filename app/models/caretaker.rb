class Caretaker < ApplicationRecord
  has_secure_password
  def to_s
    return [self.first_name, self.last_name].compact.join(' ')
  end
end
