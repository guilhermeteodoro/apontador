require "spec_helper"

describe User do
  it "should have a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "should have a first name" do
    FactoryGirl.build(:user, first_name: nil).should_not be_valid
    FactoryGirl.build(:user, first_name: "Guilherme").should be_valid
  end
  it "should not have a blank first name" do
    FactoryGirl.build(:user, first_name: "").should_not be_valid
  end
  it "should have a last name" do
    FactoryGirl.build(:user, last_name: nil).should_not be_valid
    FactoryGirl.build(:user, first_name: "Teodoro").should be_valid
  end
  it "should not have a blank last name" do
    FactoryGirl.build(:user, last_name: "").should_not be_valid
  end

  describe "address" do
    it "should not have a nil street" do
      FactoryGirl.build(:user, street: nil).should_not be_valid
    end
    it "should not have a blank street" do
      FactoryGirl.build(:user, street: "").should_not be_valid
    end
    it "should not have a nil number" do
      FactoryGirl.build(:user, number: nil).should_not be_valid
    end
    it "should not have a blank number" do
      FactoryGirl.build(:user, number: "").should_not be_valid
    end
    it "should not have a nil city" do
      FactoryGirl.build(:user, city: nil).should_not be_valid
    end
    it "should not have a blank city" do
      FactoryGirl.build(:user, city: "").should_not be_valid
    end
  end

  it "should have an valid email" do
    FactoryGirl.build(:user, email: "email@e").should_not be_valid
    FactoryGirl.build(:user, email: "email@clickjogos.com.br").should be_valid
  end
  it "should not have nil email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  it "should have an unique email" do
    user = FactoryGirl.create(:user)
    FactoryGirl.build(:user, email: user.email).should_not be_valid
  end

  describe "password" do
    it "should have an attribute to receive a plain-text password" do
      FactoryGirl.create(:user).should respond_to :plain_password=
    end
    it "should not have a nil password" do
      FactoryGirl.build(:user, password: nil).should_not be_valid
    end
    it "should not have a blank password" do
      FactoryGirl.build(:user, password: "").should_not be_valid
    end
    it "should have an encryption method for password" do
      User.should respond_to :encrypt_password
    end
    it "should have an ecrypted password" do
      Digest::SHA1.hexdigest("a1pass2b").should eql User.encrypt_password("pass")
    end
    it "should have an correspondent encrypted password" do
      FactoryGirl.build(:user, plain_password: "pass").password.should eql User.encrypt_password("pass")
    end
  end

  describe "coordinates" do
    it "should have a valid latitude" do
      FactoryGirl.build(:user, latitude: 180.0000001).should_not be_valid
      FactoryGirl.build(:user, latitude: -180.0000000).should_not be_valid
    end
    # it "should not have a nil latitude" do
    #   Factory.build(latitude: nil).should_not be_valid
    # end
    it "should have a valid longitude" do
      FactoryGirl.build(:user, longitude: 180.0000001).should_not be_valid
      FactoryGirl.build(:user, longitude: -180.0000000).should_not be_valid
    end
    # it "should not have a nil longitude" do
    #   Factory.build(longitude: nil).should be_valid
    # end
  end

  it "should have an authentication method" do
    User.should respond_to :authenticate
  end
  it "should belong to a company" do
    FactoryGirl.build(:user, company_id: 1).should be_valid
  end
  it "should have a nil company_id" do
    FactoryGirl.build(:user, company_id: nil).should be_valid
  end
end
