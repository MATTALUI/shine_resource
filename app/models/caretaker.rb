class Caretaker < ApplicationRecord
  has_secure_password
  has_many :memos
  def to_s
    return [self.first_name, self.last_name].compact.join(' ')
  end
end
