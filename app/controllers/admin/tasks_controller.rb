class Admin::TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :publish, :hide]
  before_action :require_is_admin
  layout "admin"
    def index
      @tasks = case params[:order]
        when 'by_hope_dead_line'
          Task.all.order('hope_dead_line DESC')
        when 'by_commit_wage'
          Task.all.order('commit_wage DESC')
        else
          Task.all.order('created_at DESC')
      end
    end
    def show
      @task = Task.find(params[:id])
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
        redirect_to tasks_path
      else
        render :edit
      end
    end
    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to tasks_path
    end
    def publish
      @task = Task.find(params[:id])
      @task.is_hidden = false
      @task.save
      redirect_to :back
    end
    def hide
      @task = Task.find(params[:id])
      @task.is_hidden = true
      @task.save
      redirect_to :back
    end
    private
    def task_params
      params.require(:task).permit(:title, :description, :hope_dead_line, :commit_wage, :contact_email, :is_hidden, )
    end
end
