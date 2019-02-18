class CreateServiceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :service_types, id: :uuid do |t|
      t.string  :name
      t.string  :organization_id, index: true
      t.boolean :active
      t.timestamps
    end
  end
end
