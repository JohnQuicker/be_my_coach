class CreateResumeRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :resume_relationships do |t|
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end
end
