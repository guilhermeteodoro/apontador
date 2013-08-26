# require 'spec_helper'

# describe Manager::UsersController do
#   before do
#     @manager = FactoryGirl.create(:manager)
#   end
#   describe "GET #index" do
#     before do
#       get :index, {}, {id: @manager.id, name: @manager.name, manager: @manager.manager?}
#     end
#     it "redirects to login if not logged" do
#       get :index, {}, {id: nil, name: nil, manager: nil}
#       response.should redirect_to '/login'
#     end
#     it "redirects if not logged as manager" do
#       @manager.manager = false
#       get :index, {}, {manager: @manager.manager?}
#       response.should_not be_successful
#     end
#     it "if logged" do
#       response.should be_successful
#     end
#     it "with all info from the current user" do
#       assigns(:current_user).should eql @manager
#     end
#   end
# end
