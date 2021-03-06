class TasksController < ApplicationController
  def index
    @tasks = Task.all.map {|task| TaskPresenter.new(task) }
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, flash: { notice: 'Task was successfully created.' } }
      else
        @errors = @task.errors
        format.html { render :new, flash: { alert: 'Task dont be created.' } }
      end
    end
  end

  private

  def task_params
    params.require(:task_params).permit(:title,:description)
  end
end
