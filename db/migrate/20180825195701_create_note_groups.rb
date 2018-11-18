class CreateNoteGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :note_groups, id: :uuid do |t|
      t.string     :caretaker_id
      t.time       :start_time
      t.time       :end_time
      t.date       :date
      t.integer    :total_hours
      t.boolean    :billed_for

      t.timestamps
    end
    add_index :note_groups, :caretaker_id
  end
end
