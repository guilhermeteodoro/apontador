class TasksController < LoggedController

  def edit
    @task = @current_user.task
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      flash[:notice] = if @current_user.manager
        "Tarefa alterada com sucesso!"
      else
        "Valor enviado, aguardando confirmação"
      end
      redirect_to root_path
    else
      render :edit
    end
  end

  def no_task
  end

end