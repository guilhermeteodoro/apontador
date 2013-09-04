require 'spec_helper'

describe 'login' do

  before :each do
    @manager = FactoryGirl.create(:user, manager: true, plain_password: 'manager', username: 'manager')
    @employee = FactoryGirl.create(:user, manager: false, plain_password: 'employee', username: 'employee')
    visit login_path
  end

  context 'should not login with invalid parameters:' do
    it 'wrong password' do
      fill_in :username, with: @employee.username
      fill_in :password, with: 'um_pass_errado'
      click_button :Login
      expect(page).to have_text("Invalid username/email or password")
    end
    it 'wrong username/email' do
      fill_in :username, with: 'testetestestest'
      fill_in :password, with: @employee.password
      click_button :Login
      expect(page).to have_text("Invalid username/email or password")
    end
    it 'blank username' do
      fill_in :username, with: ''
      fill_in :password, with: 'teste'
      click_button :Login
      expect(page).to have_text("Invalid username/email")
    end
    it 'blank password' do
      fill_in :username, with: 'teste'
      fill_in :password, with: ''
      click_button :Login
      expect(page).to have_text("Invalid password")
    end
  end

  context 'should login with valid parameters' do
    it 'when manager' do
      fill_in :username, with: 'manager'
      fill_in :password, with: 'manager'
      click_button :Login
      expect(page).to have_text("#{@manager.name}, bem-vindo!")
    end
    it 'when employee' do
      fill_in :username, with: 'employee'
      fill_in :password, with: 'employee'
      click_button :Login
      expect(page).to have_text("#{@employee.name}, clique em check-in para iniciar a contagem")
    end
  end
end