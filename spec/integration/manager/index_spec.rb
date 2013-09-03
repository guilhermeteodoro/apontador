#encoding: UTF-8
require 'spec_helper'

describe 'manager-index' do
  context "when user gets from the sign up" do
    let(:manager) { FactoryGirl.create :user, company_id: nil }

    before :each do
      visit manager_users_path
    end

    it 'gives the access to company creation' do
      page.should have_content('Você ainda não possui uma empresa cadastrada')
    end
  end

end