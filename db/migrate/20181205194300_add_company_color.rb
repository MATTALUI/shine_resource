class AddCompanyColor < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :color, :string, default: "yellow"
  end
end
