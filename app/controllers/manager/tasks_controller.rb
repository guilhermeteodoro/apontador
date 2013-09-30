class Manager::TasksController < LoggedController
  before_filter :manager?
  before_filter :all_with_tasks?, :has_company?, only: :new

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    @task.company = @current_user.company

    if @task.save
      redirect_to root_path, notice: "Tarefa criada com sucesso!"
    else
      flash[:error] = @task.errors.full_messages
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      flash[:notice] = "Tarefa alterada com sucesso!"
      redirect_to root_path
    else
      render :edit
    end
  end

  def accept
    @task = Task.find(params[:id])

    @task.status = "accepted"
    if @task.save
      # Mailer Aqui!
      redirect_to root_path
    else
      render :accept
    end
  end

  def renegotiate
    @task = Task.find(params[:id])

    @task.status = "pending"
    if @task.save
      # Mailer Aqui!
      redirect_to root_path
    else
      render :accept
    end
  end

  private
  def all_with_tasks?
    return if User.with_no_task(@current_user.company_id).size > 0
    redirect_to root_path, error: "Todos os funcionários tem uma tarefa."
  end
  def has_company?
    redirect_to root_path, error: "Crie uma empresa antes." unless @current_user.company
  end

end