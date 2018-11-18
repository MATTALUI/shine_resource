class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes, id: :uuid do |t|
      t.string     :client_id
      t.time       :start_time
      t.time       :end_time
      t.text       :service_description
      t.integer    :transportation_trips
      t.string     :location
      t.string     :interactions
      t.text       :support_provided
      t.text       :comments
      t.string     :note_group_id

      t.timestamps
    end
    add_index :notes, :client_id
    add_index :notes, :note_group_id
  end
end
