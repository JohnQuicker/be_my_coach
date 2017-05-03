class Account::TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :update, :edit, :destroy, :publish, :hide]
      def index
        @tasks = case params[:order]
          when 'by_hope_dead_line'
            current_user.participated_tasks.order('hope_dead_line DESC')
          when 'by_commit_wage'
            current_user.participated_tasks.order('commit_wage DESC')
          else
            current_user.participated_tasks.order('created_at DESC')
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
