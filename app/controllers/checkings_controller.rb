#encoding: UTF-8
class CheckingsController < LoggedController

  before_filter :on_going_task?, :employee?, except: [:no_task]
  before_filter :coordinates?, only: [:create, :update]

  def new
    if @current_user.checkings.present? &&
       @current_user.checkings.last.checked_in_at.present? &&
       @current_user.checkings.last.checked_out_at.nil?
       return redirect_to action: :edit
    end
    @checking = Checking.new
    render 'new'
  end

  def create
    if !@current_user.location_ok?(params[:checking][:lat].to_f, params[:checking][:lng].to_f)
      flash[:error] = "Você está fora da área de checagem ou possivelmente com o GPS desligado"
      redirect_to action: :new
      return
    end

    p params[:checking]

    @checking = Checking.new(params[:checking])
    @checking.task_id       = @current_user.task.id
    @checking.checked_in_at = Time.now
    @checking.hour_value    = @current_user.task.hour_value
    @checking.approved      = false

    if @checking.save
      redirect_to action: :edit
    else
      flash[:error] = @checking.errors.full_messages
      redirect_to action: :new
    end
  end

  def edit
    if !@current_user.task.checkings ||
        @current_user.task.checkings.last.checked_out_at.present?
      redirect_to action: :new
      return
    end
    @checking = @current_user.task.checkings.last
    render 'edit'
  end

  def update
    if !@current_user.location_ok?(params[:checking][:lat].to_f, params[:checking][:lng].to_f)
      flash[:error] = "Você está fora da área de checagem ou possivelmente com o GPS desligado"
      redirect_to action: :edit
      return
    end

    @checking = @current_user.task.checkings.last
    @checking.checked_out_at = Time.now
    @checking.set_value

    if @checking.update_attributes(checked_out_at: Time.now, value: @checking.value)
      flash[:notice] = "Checagem finalizada com sucesso"
      return redirect_to action: :new
    else
      flash[:error] = @checking.errors.full_messages
      redirect_to action: :edit
    end
  end


# REDIRECTING FILTERS
#   -If there's no problem with coordinations
#   -If the current user is employee, otherwise redirects to login
#   -If there's any task to negotiate before checking

  private
  def coordinates?
    if @current_user.latitude.nil? || @current_user.longitude.nil?
      flash[:error] = "Há um problema com o seu cadastro e não foi possível geolocalizar, entre em contato com o seu gerente."
      redirect_to check_in_path
    end
  end
  def employee?
    redirect_to manager_user_path if session[:manager]
  end
  def on_going_task?
    return redirect_to no_task_path unless @current_user.task
    redirect_to tasks_redirecter_path unless @current_user.task.status == "accepted"
  end

end
