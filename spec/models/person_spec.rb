require "spec_helper"

describe Person do
  it "should have a valid factory" do
    FactoryGirl.create(:person).should be_valid
  end

  it "should have a first name" do
    FactoryGirl.build(:person, first_name: nil).should_not be_valid
    FactoryGirl.build(:person, first_name: "Guilherme").should be_valid
  end
  it "should not have a blank first name" do
    FactoryGirl.build(:person, first_name: "").should_not be_valid
  end
  it "should have a last name" do
    FactoryGirl.build(:person, last_name: nil).should_not be_valid
    FactoryGirl.build(:person, first_name: "Teodoro").should be_valid
  end
  it "should not have a blank last name" do
    FactoryGirl.build(:person, last_name: "").should_not be_valid
  end
  it "should not have a nil address" do
    FactoryGirl.build(:person, address: nil).should_not be_valid
  end
  it "should not have a blank address" do
    FactoryGirl.build(:person, address: "").should_not be_valid
  end
  it "should have an valid email" do
    FactoryGirl.build(:person, email: "email@e").should_not be_valid
    FactoryGirl.build(:person, email: "email@clickjogos.com.br").should be_valid
  end
  it "should not have nil email" do
    FactoryGirl.build(:person, email: nil).should_not be_valid
  end
  it "should have an unique email" do
    person = FactoryGirl.create(:person)
    FactoryGirl.build(:person, email: person.email).should_not be_valid
  end
  it "should have an attribute to receive a plain-text password" do
    FactoryGirl.create(:person).should respond_to :plain_password=
  end
  it "should not have a blank password" do
    FactoryGirl.create(:person, password: nil)
  end
  it "should have an encryption method for password" do
    Person.should respond_to :encrypt_password
  end
  it "should have an ecrypted password" do
    Digest::SHA1.hexdigest("a1teste2b").should eql Person.encrypt_password("teste")
  end
  it "should have a valid latitude coordinate" do
    FactoryGirl.build(:person, latitude: 180.0000001).should_not be_valid
    FactoryGirl.build(:person, latitude: -180.0000000).should_not be_valid
  end
  it "should have a valid longitude coordinate" do
    FactoryGirl.build(:person, longitude: 85.0000001).should_not be_valid
    FactoryGirl.build(:person, longitude: -85.0000000).should_not be_valid
  end
end
