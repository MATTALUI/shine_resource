class AddTimezoneSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :caretakers, :timezone_info, :string, default: "Mountain Time (US & Canada)|-7"
    add_column :organizations, :timezone_info, :string, default: "Mountain Time (US & Canada)|-7"
  end
end
