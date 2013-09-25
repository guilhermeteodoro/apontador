class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])

    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

end