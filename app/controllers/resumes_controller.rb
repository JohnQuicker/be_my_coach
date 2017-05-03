class ResumesController < ApplicationController
  def new
    @task = Task.find(params[:task_id])
    @resume = Resume.new
  end
  def create
    @task = Task.find(params[:task_id])
    @resume = Resume.new(resume_params)
    @resume.task = @task
    @resume.user = current_user
    if @resume.save
      current_user.join!(@task)
      current_user.resumed!(@task)
      flash[:notice] = "成功提交援助邀约"
      redirect_to task_path(@task)
    else
      render :new
    end
  end
  private
  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end
end
