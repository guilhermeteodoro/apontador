class CompaniesController < LoggedController

  layout "manager"
  before_filter :manager?
  after_filter :set_company_to_current_user, only: [:create]

  def new
    return redirect_to manager_users_path if @current_user.company_id.present?
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])

    if @company.save
      redirect_to '/manager'
    else
      flash[:error] = @company.errors.full_messages
      redirect_to action: :new
    end
  end

  private
  def set_company_to_current_user
    @current_user.update_attributes(company_id: @company.id)
    current_company
  end
end
