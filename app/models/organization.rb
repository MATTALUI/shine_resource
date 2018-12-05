class Organization < ApplicationRecord
  audited
  include TimeRelated
  has_many :caretakers
  has_many :clients


  def to_s
    return self.name
  end

  def color_class(tint="darken-3")
    return "#{self.color} #{tint}"
  end
end
