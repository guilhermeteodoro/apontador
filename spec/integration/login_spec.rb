# require 'spec_helper'

# describe 'Login' do

#   before do
#     @manager = FactoryGirl.create(:user, manager: true)
#     @employee = FactoryGirl.create(:user, manager: false)
#   end

#   describe 'login' do

#     it 'should not login with wrong pass' do
#       visit login_path
#       fill_in :username, with: @employee.username
#       fill_in :password, with: 'um_pass_errado'
#       click_button :Login
#       expect(page).to have_text("Invalid username/email or password")
#     end

#     it 'should not login with wrong username/email' do
#       visit login_path
#       fill_in :username, with: 'testetestestest'
#       fill_in :password, with: @employee.password
#       click_button :Login
#       expect(page).to have_text("Invalid username/email or password")
#     end

#     # it 'should login' do
#     #   visit authenticate_path
#     #   fill_in 'email', with: @client.email
#     #   fill_in 'password', with: @client.password
#     #   click_button 'Autenticar'

#     # end
#   end

# end