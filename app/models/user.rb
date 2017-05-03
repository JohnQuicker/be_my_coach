class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 def admin?
   is_admin
 end
 has_many :tasks
 has_many :resumes
 has_many :task_relationships
 has_many :participated_tasks, :through => :task_relationships, :source => :task
 has_many :created_tasks, :through => :task_relationships, :source => :task
 has_many :resumed_tasks, :through => :task_relationships, :source => :task
 def be_concerned_about?(task)
   participated_tasks.include?(task)
 end
 def have_resumed_for?(task)
   resumed_tasks.include?(task)
 end
 def join!(task)
   participated_tasks << task
 end
 def quit!(task)
   participated_tasks.delete(task)
 end
 def resumed!(task)
   resumed_tasks << task
 end
end
