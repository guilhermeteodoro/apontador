class TasksController < LoggedController
  before_filter {
    return redirect_to tasks_redirecter_path unless @current_user.task
  }

  def redirecter
    case @current_user.task.status
      when "pending"
        redirect_to edit_task_path
      when "refused"
        redirect_to no_task_path
      when "waiting"
        redirect_to waiting_path
      else
        redirect_to root_path
    end
  end

  def edit
    return redirect_to tasks_redirecter_path if @current_user.task.status == "refused"
    @task = @current_user.task
  end

  def update
    return redirect_to tasks_redirecter_path if @current_user.task.status == "refused"

    @task = Task.find(params[:id])
    @task.status = "waiting"

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

  def refuse
    return redirect_to tasks_redirecter_path if @current_user.task.status == "refused"
    @task = Task.find(params[:id])

    if @task.update_column(:status, "refused")
      flash[:notice] = "A tarefa foi recusada com sucesso!"
      redirect_to :no_task
    else
      render :edit
    end
  end

  def no_task
    return redirect_to tasks_redirecter_path if @current_user.task.status == "pending"
  end

  def waiting
  end

end