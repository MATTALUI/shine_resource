class CreateMemos < ActiveRecord::Migration[5.1]
  def change
    create_table :memos do |t|
      t.string :client_id, index: true, null: false
      t.string :caretaker_id, index: true, null: false
      t.text   :encrypted_body
      t.text   :encrypted_body_iv

      t.timestamps
    end
  end
end
