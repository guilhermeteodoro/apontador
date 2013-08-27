require 'spec_helper'

describe Manager::UsersController do
  before do
    @manager = FactoryGirl.create(:user, manager: true)
  end

  describe "GET #index" do
    before do
      get :index, {}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
    end
    it "redirects to login if not logged" do
      get :index, {}, {id: nil, name: nil, manager: nil}
      response.should redirect_to '/login'
    end
    it "redirects if not logged as manager" do
      @manager.manager = false
      get :index, {}, {manager: @manager.manager?}
      response.should_not be_successful
    end
    it "if logged" do
      response.should be_successful
    end
    it "with all info from the current user" do
      assigns(:current_user).should eql @manager
    end
  end

  describe "GET #new" do
    it "not logged" do
      get :new
      response.should be_successful
    end
    it "logged" do
      get :new, {}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
      response.should be_successful
    end
  end

  describe "GET #edit" do
    it "if logged and manager" do
      get :edit, {}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
      response.should be_successful
    end
    it "redirects if logged and not manager" do
      get :edit, {}, {id: @manager.id, name: @manager.name, manager: false}
      response.should redirect_to login_path
    end
    it "redirects if logged" do
      get :edit, {}, {}
      response.should redirect_to login_path
    end
  end

  describe "POST #create" do
    it "gets manager index after save" do
      post :create, user: FactoryGirl.attributes_for(:user)
      response.should redirect_to action: :index
    end

    it "redirects if get error" do
      post :create, user: FactoryGirl.attributes_for(:user, first_name: nil)
      response.should redirect_to action: :new
    end
  end

  describe "PUT #update" do
    it "be successful if logged and manager" do
      put :update, {user: {first_name: "Jonas"}}, {id: @manager.id, name: @manager.name, manager: true}
      @manager.first_name = ""
      assigns(:current_user).should eql @manager
      response.should redirect_to manager_user_path
    end

    describe "doesn't update" do
      it "redirects if gets an error" do
        put :update, {user: {first_name: nil}}, {id: @manager.id, name: @manager.name, manager: true}
        response.should_not be_successful
      end

      it "redirects if not manager" do
        put :update, {user: {first_name: "Jonas"}}, {id: @manager.id, name: @manager.name, manager: false}
        response.should redirect_to login_path
      end

      it "redirects if not logged" do
        put :update, {user: {first_name: "Jonas"}}, {}
        response.should redirect_to login_path
      end
    end
  end

  # describe "DELETE #destroy" do
  #   # before :each do
  #   #   @manager = FactoryGirl.create(:user)
  #   #   request.session[:id] = @manager.id
  #   #   request.session[:name] = @manager.first_name
  #   #   request.session[:manager] = true
  #   #   controller.stub(:current_user).and_return(@current_user)
  #   # end
  #   it "be successful and redirects if logged and manager" do
  #     expect{
  #       delete :destroy, {}, {id: @manager.id, name: @manager.name, manager: true}
  #       }.to redirect_to logout_path
  #   end
  # end

  describe "resolves layout" do
    it "rendering 'login' on new action" do
      get :new
      response.should render_template(layout: 'layouts/login')
    end
    it "rendering 'manager' on other actions" do
      get :index, {}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
      response.should render_template(layout: 'layouts/manager')
    end
  end

end
