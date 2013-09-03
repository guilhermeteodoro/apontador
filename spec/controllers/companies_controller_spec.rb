require 'spec_helper'

describe CompaniesController do
  before do
    @manager = FactoryGirl.create(:user, manager: true, company_id: nil)
    @employee = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
  end

  describe "GET #new" do
    it "logged" do
      sign_in @manager
      get :new, {}
      response.should be_successful
    end
    it "redirects if the user already have a company" do
      @manager = FactoryGirl.create(:user, manager: true, company_id: 1)
      sign_in @manager
      get :new, {}
      response.should redirect_to manager_users_path
    end
    it "redirects if not manager" do
      sign_in @employee
      get :new, {}
      response.should redirect_to login_path
    end
    it "redirects if not logged" do
      get :new
      response.should redirect_to login_path
    end
  end

  describe "POST #create" do
    it "is successful" do
      sign_in @manager
      post :create, company: FactoryGirl.attributes_for(:company)
      response.should redirect_to manager_users_path
    end
    it "redirects if not manager" do
      sign_in @employee
      post :create, {}
      response.should redirect_to login_path
    end
    it "redirects if not logged" do
      post :create
      response.should redirect_to login_path
    end
  end

end
