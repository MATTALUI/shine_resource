class NoteGroup < ApplicationRecord
  audited

  belongs_to :caretaker
  has_many :notes

  scope :caretaker,     ->(id){ where(caretaker_id: id) }
  scope :between_dates, ->(s,e){ where(date: s..e) }

  def time_range
    f = "%l:%M%p %Z"
    return "#{self.start_time.strftime(f)}-#{self.end_time.strftime(f)}"
  end

  def self.most_recent
    order(date: :desc).limit(1).first
  end
end
