class NoteGroup < ApplicationRecord
  audited

  belongs_to :caretaker
  has_many :notes


  # TODO: there are some weirdnesses with this query because
  # we're using string UUIDs ans psql that make default joins
  # incompatible. This will need to be fixed.

  # Forgive me for my sins.
  scope :organization,  ->(id){
    caretaker_ids = Caretaker.where(organization_id: id).pluck(:id)
    self.where(caretaker_id: caretaker_ids)
  }
  scope :caretaker,     ->(id){ where(caretaker_id: id) }
  scope :unbilled,      ->{ where(billed_for: false) }
  scope :billed,        ->{ where(billed_for: true) }
  scope :between_dates, ->(s,e){ where(date: s..e) }

  def time_range
    f = "%l:%M%p %Z"
    return "#{self.start_time.strftime(f)}-#{self.end_time.strftime(f)}"
  end

  def incident_report?
    note_ids = Note.where(note_group_id: self.id).pluck(:id)
    return IncidentReport.exists?(note_id: note_ids)
  end

  def self.most_recent
    order(date: :desc).limit(1).first
  end
end
