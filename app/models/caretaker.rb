class Caretaker < ApplicationRecord
  audited
  
  has_secure_password
  belongs_to :organization
  has_many :memos
  has_many :note_groups

  def to_s
    return [self.first_name, self.last_name].compact.join(' ')
  end

  def notes_due
    last_group = self.note_groups.most_recent

  end
end
