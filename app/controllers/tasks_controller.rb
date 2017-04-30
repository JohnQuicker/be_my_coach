class TasksController < ApplicationController

before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, ]

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
      redirect_to admin_tasks_path
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

  private

  def task_params
    params.require(:task).permit(:title, :description, :hope_dead_line, :commit_wage, :contact_email, :is_hidden, )
  end
end
