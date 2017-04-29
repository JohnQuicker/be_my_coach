class AddIsHiddenToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :is_hidden, :boolean, default: true
  end
end
