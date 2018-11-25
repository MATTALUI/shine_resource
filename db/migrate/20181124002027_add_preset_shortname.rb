class AddPresetShortname < ActiveRecord::Migration[5.1]
  def change
    add_column :presets, :short_code, :string
    rename_column :presets, :type, :preset_type
  end
end
