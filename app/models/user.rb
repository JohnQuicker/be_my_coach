class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 def admin?
   is_admin
 end
 has_many :resumes
 has_many :tasks
 has_many :task_relationships
 has_many :participated_tasks, :through => :task_relationships, :source => :task
end
