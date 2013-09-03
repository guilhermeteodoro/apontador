require 'spec_helper'

describe UsersController do
  before do
    @manager = FactoryGirl.create(:user, manager: true)
    @employee = FactoryGirl.create(:user, manager: false)
  end

  describe "GET #show" do
    it "logged" do
      get :new, {}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
      response.should be_successful
    end
    it "redirects if not manager" do
      get :new, {}, {id: @employee.id, name: @employee.name, manager: @employee.manager?}
      response.should redirect_to login_path
    end
    it "redirects if not logged" do
      get :new
      response.should redirect_to login_path
    end
  end

  describe "GET #new" do
    it "logged" do
      get :new, {}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
      response.should be_successful
    end
    it "redirects if not manager" do
      get :new, {}, {id: @employee.id, name: @employee.name, manager: @employee.manager?}
      response.should redirect_to login_path
    end
    it "redirects if not logged" do
      get :new
      response.should redirect_to login_path
    end
  end

  describe "GET #edit" do
    context "logged and employee" do
      it "is successful" do
        @employee = FactoryGirl.create(:user, manager: false)
        get :edit, {}, {id: @employee.id, name: @employee.name, manager: @employee.manager?}
        response.should be_successful
      end
    end

    context "when manager" do
      it "if logged" do
        @company = FactoryGirl.create(:company)
        @manager = FactoryGirl.create(:user, manager: true, company_id: @company.id)
        @employee = FactoryGirl.create(:user, company_id: @company.id)
        sign_in @manager
        get :edit, username: @employee.username
        response.should be_successful
      end
    end
    it "redirects if not logged" do
      get :edit, {}, {}
      response.should redirect_to login_path
    end
  end

  describe "POST #create" do
    it "gets manager index after save" do
      post :create, {user: FactoryGirl.attributes_for(:user, manager: false)}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
      response.should redirect_to manager_user_path
    end
    it "redirects if get error" do
      post :create, {user: FactoryGirl.attributes_for(:user, first_name: nil)}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
      response.should redirect_to action: :new
    end
  end

  describe "PUT #update" do
    before :each do
      @company = FactoryGirl.create(:company)
      @manager = FactoryGirl.create(:user, manager: true, company_id: @company.id)
      @employee = FactoryGirl.create(:user, company_id: @company.id)
      sign_in @manager
    end

    context "is successful" do
      it "logged and manager" do
        @employee.first_name = "Jonas"
        put :update, username: @employee.username, user: {first_name: "Jonas"}
        expect(User.find_by_username(@employee.username).first_name).to eql @employee.first_name
        response.should redirect_to user_path(@employee.username)
      end
      it "logged and employee" do
        sign_in @employee
        @employee.first_name = "Jonas"
        put :update, username: @employee.username, user: {first_name: "Jonas"}
        expect(User.find_by_username(@employee.username).first_name).to eql @employee.first_name
        response.should redirect_to check_in_path
      end
    end

    context "doesn't update" do
      it "and redirects if gets an error" do
        put :update, username: @employee.username, user: {first_name: nil}
        response.should_not be_successful
      end
      it "redirects if not logged" do
        put :update, {user: {first_name: "Jonas"}}, {}
        response.should redirect_to login_path
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @company = FactoryGirl.create(:company)
      @manager = FactoryGirl.create(:user, manager: true, company_id: @company.id)
      @employee = FactoryGirl.create(:user, company_id: @company.id)
    end

    context "when logged and manager" do
      it "redirects to manager index" do
        sign_in @manager
        delete :destroy, username: @employee.username
        response.should redirect_to manager_users_path
      end
    end
  end

  describe "resolves layout" do
    before do
      @company = FactoryGirl.create(:company)
      @manager = FactoryGirl.create(:user, manager: true, company_id: @company.id)
      @employee = FactoryGirl.create(:user, company_id: @company.id)
    end

    context "rendering employee layout" do
      before :each do
        sign_in @employee
      end
      it "on action edit" do
        get :edit
        response.should render_template(layout: 'layouts/employee')
      end
      it "on action report" do
        get :report
        response.should render_template(layout: 'layouts/employee')
      end
    end

    context "rendering manager layout" do
      before :each do
        sign_in @manager
      end
      it "on action edit" do
        get :edit, username: @employee.username
        response.should render_template(layout: 'layouts/manager')
      end
    end
  end
end
