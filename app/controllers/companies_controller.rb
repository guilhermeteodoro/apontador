class CompaniesController < ApplicationController
  before_filter :logged?, :manager?, except: [:new, :create]
  def new
    @company = Company.new
  end
  def create
    @company = Company.new(params[:company])

    if @company.save
      redirect_to 'signup'
    else
      flash[:notice] = "It's been an error, try again"
      redirect_to action: :new
    end
end
