class Manager::TasksController < LoggedController
  before_filter :manager?, except: [:no_task, :task_in_negotiation, :update]
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

  private
  def all_with_tasks?
    return if User.with_no_task(@current_user.company_id).size > 0
    redirect_to root_path, error: "Todos os funcionários tem uma tarefa."
  end
  def has_company?
    redirect_to root_path, error: "Crie uma empresa antes." unless @current_user.company
  end

end