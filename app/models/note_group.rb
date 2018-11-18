class NoteGroup < ApplicationRecord
  audited
  
  belongs_to :caretaker
  has_many :notes

  def time_range
    f = "%l:%M%p %Z"
    return "#{self.start_time.strftime(f)}-#{self.end_time.strftime(f)}"
  end

  def self.most_recent
    order(date: :desc).limit(1).first
  end
end
