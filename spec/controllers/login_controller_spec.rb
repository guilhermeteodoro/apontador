require 'spec_helper'

describe LoginController do
  it "GET #login" do
    get :login
    response.should be_successful
  end
  describe "not GET #login" do
    it "without username/email and password" do
      post :login
      flash[:error].should eql "Invalid username/email or password"
    end
    it "without username/email" do
      post :login, { username: "", password: "pass" }
      flash[:error].should eql "Invalid username/email"
    end
    it "without password" do
      post :login, { username: "email@email.com" }
      flash[:error].should eql "Invalid password"
    end
    it "with invalid username/email" do
      post :login, { username: "email@e", password: "pass" }
      flash[:error].should eql "Invalid username/email or password"
    end
    it "with invalid password" do
      user = FactoryGirl.build(:user)
      post :login, { username: user.email, password: "ois" }
      flash[:error].should eql "Invalid username/email or password"
    end
  end
  describe "login" do
    context "when manager," do
        it "with valid information" do
          user = FactoryGirl.create(:user, plain_password: "pass", manager: true)
          post :login, { username: user.email, password: "pass" }
          session[:id].should eql user.id
          session[:name].should eql "#{user.first_name} #{user.last_name}"
          session[:manager].should eql user.manager?
          response.should redirect_to '/manager'
        end
      end
    context "when user," do
      it "with valid information" do
        user = FactoryGirl.create(:user, plain_password: "pass", manager: false)
        post :login, { username: user.email, password: "pass" }
        session[:id].should eql user.id
        session[:name].should eql "#{user.first_name} #{user.last_name}"
        session[:manager].should eql user.manager?
        response.should redirect_to '/check-in'
      end
    end
  end
  it "should logout" do
    get :logout
    session[:id].should eql nil
    session[:name].should eql nil
    session[:manager].should eql nil
    expect(response).to redirect_to action: :login
  end

end
