class AddNoteServiceType < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :service_type_id, :string, index: true
  end
end
