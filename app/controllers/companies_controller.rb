class CompaniesController < ApplicationController

  layout "manager"
  before_filter :logged?, :current_user, :manager?
  after_filter :set_company_to_current_user, only: [:create]

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])

    if @company.save
      redirect_to '/manager'
    else
      flash[:notice] = @company.errors.full_messages
      redirect_to action: :new
    end
  end

  private
  def set_company_to_current_user
    @current_user.update_attributes(company_id: @company.id)
    current_company
  end
end
