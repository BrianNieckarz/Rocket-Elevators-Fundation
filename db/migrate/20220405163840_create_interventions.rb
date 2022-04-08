class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|

      t.string :author, null: false
      t.string :customer_id
      t.string :building_id
      t.string :battery_id
      t.string :column_id
      t.string :elevator_id
      t.string :employee_id
      t.datetime :start_date, null: true
      t.datetime :end_date, null: true
      t.string :result, default: "Incomplete"
      t.text :report
      t.string :status, default: "Pending"

    end
  end
end
