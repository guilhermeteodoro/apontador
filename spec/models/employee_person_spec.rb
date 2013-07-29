require 'spec_helper'

describe EmployeePerson do
  it "should have a valid factory" do
    FactoryGirl.build(:employee).should be_valid
  end

  it "should have an unique cpf" do
    employee = FactoryGirl.create(:employee)
    FactoryGirl.build(:employee, cpf: employee.cpf).should_not be_valid
    FactoryGirl.build(:employee, cpf: 21345678901).should be_valid
  end
  it "should not have a nil cpf" do
    FactoryGirl.build(:employee, cpf: nil).should_not be_valid
  end
  it "should have a cpf up to 11 numbers" do
    FactoryGirl.build(:employee, cpf: 12345678901).should be_valid
    FactoryGirl.build(:employee, cpf: 123456789012).should_not be_valid
    FactoryGirl.build(:employee, cpf: 1234567890).should_not be_valid
  end
end
