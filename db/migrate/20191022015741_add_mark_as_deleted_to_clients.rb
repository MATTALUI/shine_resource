class AddMarkAsDeletedToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :mark_as_deleted, :boolean, default: false
  end
end
