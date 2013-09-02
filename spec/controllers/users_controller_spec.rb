require 'spec_helper'

describe UsersController do
  before do
    @manager = FactoryGirl.create(:user, manager: true)
    @employee = FactoryGirl.create(:user, manager: false)
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

  # describe "GET #edit" do

  #   describe "when employee" do
  #     it "if logged" do
  #       get :edit, {}, {id: @employee.id, name: @employee.name, manager: @employee.manager?}
  #       response.should be_successful
  #     end
  #   end

  #   describe "when manager" do
  #     it "if logged" do
  #       get :edit, { username: @employee.username }, { id: @manager.id, name: @manager.name, manager: @manager.manager? }
  #       response.should be_successful
  #     end
  #   end

  #   it "redirects if not logged" do
  #     get :edit, {}, {}
  #     response.should redirect_to login_path
  #   end

  # end

  # describe "POST #create" do
  #   it "gets manager index after save" do
  #     post :create, {user: FactoryGirl.attributes_for(:user)}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
  #     response.should redirect_to manager_user_path
  #   end

  # #   it "redirects if get error" do
  # #     post :create, user: FactoryGirl.attributes_for(:user, first_name: nil)
  # #     response.should redirect_to action: :new
  # #   end
  # end

  # describe "PUT #update" do
  #   it "be successful if logged and manager" do
  #     put :update, {user: {first_name: "Jonas"}}, {id: @employee.id, name: @employee.name, manager: true}
  #     @employee.first_name = ""
  #     assigns(:current_user).should eql @employee
  #     response.should redirect_to manager_user_path
  #   end

  #   describe "doesn't update" do
  #     it "redirects if gets an error" do
  #       put :update, {user: {first_name: nil}}, {id: @employee.id, name: @employee.name, manager: true}
  #       response.should_not be_successful
  #     end

  #     it "redirects if not manager" do
  #       put :update, {user: {first_name: "Jonas"}}, {id: @employee.id, name: @employee.name, manager: false}
  #       response.should redirect_to login_path
  #     end

  #     it "redirects if not logged" do
  #       put :update, {user: {first_name: "Jonas"}}, {}
  #       response.should redirect_to login_path
  #     end
  #   end
  # end

  # describe "resolves layout" do
  #   it "rendering 'login' on new action" do
  #     get :new
  #     response.should render_template(layout: 'layouts/login')
  #   end
  #   it "rendering 'manager' on other actions" do
  #     get :index, {}, {id: @employee.id, name: @employee.name, manager: @employee.manager?}
  #     response.should render_template(layout: 'layouts/manager')
  #   end
  # end

end