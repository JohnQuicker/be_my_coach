class AddMoreDetailToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :hope_dead_line, :integer
    add_column :tasks, :commit_wage, :integer
    add_column :tasks, :contact_email, :string
  end
end
