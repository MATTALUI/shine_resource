class Organization < ApplicationRecord
  audited
  include TimeRelated
  has_many :caretakers
  has_many :clients


  def to_s
    return self.name
  end
end
