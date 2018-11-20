class ChangeAuditUserColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :audits, :user_id, :string
  end
end
