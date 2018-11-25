class Preset < ApplicationRecord
  belongs_to :caretaker
  belongs_to :client, optional: true

  scope :caretaker,      ->(caretaker_id){ where(caretaker_id: caretaker_id) }
  scope :client_neutral, ->{ where(client_id: nil) }
  scope :active,         ->{ where(active: true) }

  def to_s
    return self.short_code.presence || self.text.presence
  end
end
