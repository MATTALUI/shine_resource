class AddPasswordResetToken < ActiveRecord::Migration[5.1]
  def change
    add_column :caretakers, :password_reset_token, :string, limit: 69, index: true
  end
end
