class Caretaker < ApplicationRecord
  audited
  has_secure_password validations: false
  include TimeRelated
  belongs_to :organization
  has_many :memos
  has_many :note_groups
  has_many :presets

  def to_s
    return [self.first_name, self.last_name].compact.join(' ')
  end

  def notes_due
    last_group = self.note_groups.most_recent
  end

  def pending?
    return self.password_digest.blank? && self.password_reset_token.present?
  end
end
