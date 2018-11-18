class Memo < ApplicationRecord
  audited
  
  attr_encrypted :body, key: ENV["encryption_key"]
  belongs_to :caretaker
  belongs_to :client
  def to_s
    return self.body
  end
end
