class ChangeNullToFalse < ActiveRecord::Migration[5.2]
  def change

    remove_column :interventions, :customer_id, :string
    add_column :interventions, :customer_id, :string, null: false

    remove_column :interventions, :building_id, :string
    add_column :interventions, :building_id, :string, null: false

    remove_column :interventions, :battery_id, :string
    add_column :interventions, :battery_id, :string, null: false

  end
end
