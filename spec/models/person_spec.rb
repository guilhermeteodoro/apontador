require "spec_helper"

describe Person do
  it "should have a valid factory" do
    FactoryGirl.create(:employee).should be_valid
    FactoryGirl.create(:manager).should be_valid
  end

  it "should have a first name" do
    FactoryGirl.build(:employee, first_name: nil).should_not be_valid
    FactoryGirl.build(:employee, first_name: "Guilherme").should be_valid
  end
  it "should not have a blank first name" do
    FactoryGirl.build(:employee, first_name: "").should_not be_valid
  end
  it "should have a last name" do
    FactoryGirl.build(:employee, last_name: nil).should_not be_valid
    FactoryGirl.build(:employee, first_name: "Teodoro").should be_valid
  end
  it "should not have a blank last name" do
    FactoryGirl.build(:employee, last_name: "").should_not be_valid
  end
  it "should have an valid email" do
    FactoryGirl.build(:employee, email: "email@e").should_not be_valid
    FactoryGirl.build(:employee, email: "email@clickjogos.com.br").should be_valid
  end
  it "should not have nil email" do
    FactoryGirl.build(:employee, email: nil).should_not be_valid
  end
  it "should have an unique email" do
    person = FactoryGirl.create(:employee)
    FactoryGirl.build(:employee, email: person.email).should_not be_valid
  end
  it "should have an attribute to receive a plain-text password" do
    FactoryGirl.create(:employee).should respond_to :plain_password=
  end
  it "should not have a blank password" do
    FactoryGirl.create(:employee, password: nil)
  end
  it "should have an encryption method for password" do
    Person.should respond_to :encrypt_password
  end
  it "should have an ecrypted password" do
    Digest::SHA1.hexdigest("a1teste2b").should eql Person.encrypt_password("teste")
  end
  it "should have a cpf up to 11 numbers" do
    FactoryGirl.build(:employee, cpf: 123456789012).should_not be_valid
    FactoryGirl.build(:employee, cpf: 1234567890).should_not be_valid
  end
  it "should have a valid latitude coordinate" do
    FactoryGirl.build(:employee, latitude: 180.0000001).should_not be_valid
    FactoryGirl.build(:employee, latitude: -180.0000000).should_not be_valid
  end
  it "should have a valid longitude coordinate" do
    FactoryGirl.build(:employee, longitude: 85.0000001).should_not be_valid
    FactoryGirl.build(:employee, longitude: -85.0000000).should_not be_valid
  end
  it "should have a method to know if the person is admin" do
    FactoryGirl.build(:employee).should respond_to :admin?
  end
  context "when manager" do
    it "should have a method 'admin?' which returns true" do
      FactoryGirl.build(:manager).admin?.should be_true
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
  context "when employee" do
    it "should have a method 'admin?' which returns false" do
      FactoryGirl.build(:employee).admin?.should be_false
    end
    it "should have a nil or blank institution name" do
      FactoryGirl.build(:employee, institution: nil).should be_valid
      FactoryGirl.build(:employee, institution: "").should be_valid
    end
    it "should have a valid institution name" do
      FactoryGirl.build(:employee, institution: Faker::Name.last_name).should be_valid
    end
  end
end
