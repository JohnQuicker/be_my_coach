class TasksController < ApplicationController

before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :join, :quit]

  # def index
  #   @tasks = Task.where(:is_hidden => false)
  # end
  #
  def index
    @tasks = case params[:order]
      when 'by_hope_dead_line'
        Task.where(is_hidden: false).order('hope_dead_line DESC')
      when 'by_commit_wage'
        Task.where(is_hidden: false).order('commit_wage DESC')
      else
        Task.where(is_hidden: false).order('created_at DESC')
    end
  end

  def show
    @task = Task.find(params[:id])
    if @task.is_hidden
      flash[:warning] = "您想从后门进来？瞬间移动回大门前！"
      redirect_to root_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      current_user.join!(@task)
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to admin_tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to admin_tasks_path
  end

  def join
    @task = Task.find(params[:id])
    if !current_user.be_concerned_about?(@task)
      current_user.join!(@task)
      flash[:notice] = "关注本课题成功"
    else
      flash[:warning] = "你已经关注这个课题了"
    end
    redirect_to task_path(@task)
  end
  def quit
    @task = Task.find(params[:id])
    if current_user.be_concerned_about?(@task)
      current_user.quit!(@task)
      flash[:alert] = "已经取消关注"
    else
      flash[:warning] = "你已经没有关注这个课题了"
    end
    redirect_to task_path(@task)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :hope_dead_line, :commit_wage, :contact_email, :is_hidden )
  end
end
