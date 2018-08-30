class CreateIncedentReports < ActiveRecord::Migration[5.1]
  def change
    create_table :incedent_reports, id: :uuid do |t|

      t.timestamps
    end
  end
end
