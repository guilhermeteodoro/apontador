require 'spec_helper'

describe CheckingsController do
  before do
    @manager = FactoryGirl.create(:user, manager: true)
    @employee = FactoryGirl.create(:user, manager: false)
  end

  describe "GET #new" do
    it "if logged and manager" do
      get :new, {}, {id: @manager.id, name: @manager.name, manager: true}
      response.should be_successful
    end
    it "redirects if not manager" do
      get :new, {}, {id: @employee.id, name: @employee.name, manager: @employee.manager?}
      response.should redirect_to login_path
    end
  end
end
