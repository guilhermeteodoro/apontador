class TasksController < LoggedController
  before_filter :manager?, except: [:no_task, :task_in_negotiation]

  def show
  end

  def new
    @task = Task.new
    @employees = User.employees(@current_user.company_id) if @current_user.company_id.present?
  end

  def create
    @task = Task.new(params[:task])

    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:task])
  end

  def update

  end

  def no_task
  end

  def task_in_negotiation
    #criar o redirecter dos steps aqui. Se o funcionario ja enviou uma resposta
    #deve ser redirecionado pra uma pagina de "aguarde"
  end

end