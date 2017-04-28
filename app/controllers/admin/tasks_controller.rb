class Admin::TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, ]
  before_action :require_is_admin

    def index
      @tasks = Task.all
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

    def require_is_admin
        if !current_user.admin?
          flash[:alert] = 'You are not admin'
          redirect_to root_path
        end
    end
    
    private

    def task_params
      params.require(:task).permit(:title, :description)
    end
end
