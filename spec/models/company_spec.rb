require 'spec_helper'

describe Company do
  it "should have a valid factory" do
    FactoryGirl.create(:company).should be_valid
  end

  it "should have a valid name" do
    FactoryGirl.build(:company, name: "UNIP" ).should be_valid
  end
  it "should not have a nil name" do
    FactoryGirl.build(:company, name: nil).should_not be_valid
  end
  it "should not have a blank name" do
    FactoryGirl.build(:company, name: "").should_not be_valid
  end
  it "should have a valid cnpj" do
    FactoryGirl.build(:company, cnpj: 12345678901 ).should be_valid
  end
  it "should not have a nil cnpj" do
    FactoryGirl.build(:company, cnpj: nil).should_not be_valid
  end
  it "should have a cnpj up to 11 numbers only" do
    FactoryGirl.build(:company, cnpj: 123456789012 ).should_not be_valid
    FactoryGirl.build(:company, cnpj: 123456789 ).should_not be_valid
  end
end
