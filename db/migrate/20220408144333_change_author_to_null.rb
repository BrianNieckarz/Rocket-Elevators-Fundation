class ChangeAuthorToNull < ActiveRecord::Migration[5.2]
  def change
    remove_column :interventions, :author, :string
    add_column :interventions, :author, :string
  end
end
