require 'spec_helper'

describe CheckingsController do
  before do
    @manager = FactoryGirl.create(:user, manager: true)
    @employee = FactoryGirl.create(:user, manager: false)
  end

  describe "GET #new" do

    it "is successful" do
      get :new, {}, {id: @employee.id, name: @employee.name, manager: false}
      response.should be_successful
    end

    it "redirects if it has an incomplete checking" do
      employee = FactoryGirl.create(:user, manager: false)
      checking = FactoryGirl.create(:checking, user_id: employee.id, checked_out_at: nil)
      get :new, {}, {id: employee.id, name: employee.name, manager: false}
      response.should redirect_to action: :edit
    end

    it "redirect logged and manager" do
      get :new, {}, {id: @manager.id, name: @manager.name, manager: true}
      response.should redirect_to manager_user_path
    end

    it "redirect if not logged" do
      get :new, {}, {}
      response.should redirect_to login_path
    end

  end

  describe "GET #edit" do

    it "is successful if logged and not manager" do
      checking = FactoryGirl.create(:checking, user_id: @employee.id, checked_out_at: nil)
      get :edit, {}, {id: @employee.id, name: @employee.name, manager: false}
      response.should be_successful
    end

    it "redirects if it hasn't an incomplete checking" do
      checking = FactoryGirl.create(:checking, user_id: @employee.id)
      get :edit, {}, {id: @employee.id, name: @employee.name, manager: false}
      response.should redirect_to action: :new
    end

    it "redirects if it hasn't ever checked" do
      get :edit, {}, {id: @employee.id, name: @employee.name, manager: false}
      response.should redirect_to action: :new
    end

  end

  describe "POST #create" do

    it "is successful if it's in the range" do
      @employee = FactoryGirl.create(:user, manager: false, latitude: 23.0000, longitude: 33.0000)
      post :create, {checking: {lat: 23.00001, lng: 33.000004} }, {id: @employee.id, name: @employee.name, manager: false}
      response.should redirect_to action: :edit
    end

    it "is redirects if it's out of the range" do
      @employee = FactoryGirl.create(:user, manager: false, latitude: 23.0000, longitude: 33.0000)
      post :create, {checking: {lat: 23.03, lng: 33.09} }, {id: @employee.id, name: @employee.name, manager: false}
      response.should redirect_to action: :new
    end

  end

  describe "PUT #update" do

    it "is successful if it's in the range" do
      @employee = FactoryGirl.create(:user, manager: false, latitude: 23.0000, longitude: 33.0000)
      checking = FactoryGirl.create(:checking, user_id: @employee.id, checked_out_at: nil)
      put :update, {checking: {lat: 23.00001, lng: 33.000004} }, {id: @employee.id, name: @employee.name, manager: false}
      response.should redirect_to action: :new
    end

    it "is redirects if it's out of the range" do
      @employee = FactoryGirl.create(:user, manager: false, latitude: 23.0000, longitude: 33.0000)
      checking = FactoryGirl.create(:checking, user_id: @employee.id, checked_out_at: nil)
      put :update, {checking: {lat: 23.03, lng: 33.09} }, {id: @employee.id, name: @employee.name, manager: false}
      response.should redirect_to action: :edit
    end

  end
end
