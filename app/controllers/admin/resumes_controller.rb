class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout 'admin'
  def index
    @task = Task.find(params[:task_id])
    @resumes = @task.resumes.order('created_at DESC')
  end
end
