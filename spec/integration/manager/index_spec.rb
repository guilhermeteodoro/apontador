#encoding: UTF-8
require 'spec_helper'

describe 'manager-index' do
  context "when the user gets from the sign up/login for the first time" do
    let!(:manager) { FactoryGirl.create(:user, manager: true, company_id: nil, plain_password: 'manager', username: 'manager') }

    before do
      visit login_path

      fill_in :username, with: 'manager'
      fill_in :password, with: 'manager'
      click_button :Login
    end

    it 'gives the access to company creation' do
      page.should have_content('Você ainda não possui uma empresa cadastrada')
      page.should have_button('Nova Empresa')
      click_button 'Nova Empresa'
      expect(page).to have_content('Criar Empresa')
    end

    it 'gives no access to employee creation' do
      page.should_not have_button('Novo Funcionário')
    end

    it 'gives no access to employee list' do
      page.should_not have_selector('table')
    end
  end

  context "when the user already have a company" do
    let!(:company) { FactoryGirl.create(:company) }
    let!(:manager) { FactoryGirl.create(:user, manager: true, company_id: company.id, plain_password: 'manager', username: 'manager') }

    before do
      visit login_path

      fill_in :username, with: 'manager'
      fill_in :password, with: 'manager'
      click_button :Login
    end

    it "gives access to employee creation" do
      page.should have_link('Novo Funcionário')
    end

    it "shows a message if has no employees" do
      page.should have_content('Você ainda não possui funcionários')
    end

    it "shows a list of all employees" do
      employee = FactoryGirl.create(:user, manager: false, company_id: company.id)
      visit current_path
      page.find('ul h3').should have_link(employee.name)
      page.find('ul li#email').should have_text(employee.email)
      page.find('ul li#address').should have_text(employee.full_address)
      page.find('ul li#edit').should have_link('Editar Informações')
    end
  end

end