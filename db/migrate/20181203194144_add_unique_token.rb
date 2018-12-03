class AddUniqueToken < ActiveRecord::Migration[5.1]
  def change
    add_index :caretakers, :password_reset_token, unique: true
  end
end
