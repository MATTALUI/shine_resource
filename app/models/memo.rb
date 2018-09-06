class Memo < ApplicationRecord
  attr_encrypted :body, key: ENV["encryption_key"]
  belongs_to :caretaker
  belongs_to :client
end
