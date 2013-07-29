require 'spec_helper'

describe ManagerPerson do
  it "should have a valid factory" do
    FactoryGirl.build(:manager).should be_valid
  end
  it "should have a valid cnpj" do
    FactoryGirl.build(:manager, cnpj: 12345678901).should be_valid
    FactoryGirl.build(:manager, cnpj: 1234567890).should_not be_valid
    FactoryGirl.build(:manager, cnpj: 123456789012).should_not be_valid
  end
  it "should not have a nil cnpj" do
    FactoryGirl.build(:manager, cnpj: 12345678901).cnpj.should_not eql nil
  end
  it "should have an unique cnpj" do
    manager = FactoryGirl.create(:manager)
    FactoryGirl.build(:manager, cnpj: manager.cnpj).should_not be_valid
  end
  it "should have a valid institution name" do
    FactoryGirl.build(:manager, institution: Faker::Name.last_name).should be_valid
  end
  it "should not have a blank institution name" do
    FactoryGirl.build(:manager, institution: "").should_not be_valid
  end
  it "should not have a nil institution name" do
    FactoryGirl.build(:manager, institution: nil).should_not be_valid
  end
end
