class CreatePresets < ActiveRecord::Migration[5.1]
  def change
    create_table :presets, id: :uuid do |t|
      t.string  :caretaker_id, null: false
      t.string  :client_id
      t.string  :type
      t.text    :text, null: false
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :presets, :caretaker_id
    add_index :presets, :client_id
  end
end
