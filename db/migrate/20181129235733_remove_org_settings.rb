class RemoveOrgSettings < ActiveRecord::Migration[5.1]
  def change
    drop_table :organization_settings
  end
end
