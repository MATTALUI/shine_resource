class CreateCaretakers < ActiveRecord::Migration[5.1]
  def change
    create_table :caretakers, id: :uuid do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email, unique: true
      t.string  :phone
      t.string  :password_digest
      t.string  :organization_id
      t.boolean :master, default: false

      t.timestamps
    end
    add_index :caretakers, :email
    add_index :caretakers, :organization_id

  end
end
