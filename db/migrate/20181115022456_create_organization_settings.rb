class CreateOrganizationSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_settings, id: :uuid do |t|
      t.string :organization_id

      t.timestamps
    end
    add_index :organization_settings, :organization_id
  end
end
