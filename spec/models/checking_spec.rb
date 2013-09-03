require 'spec_helper'

describe Checking do
  it "should have a valid factory" do
    FactoryGirl.build(:checking).should be_valid
  end

  describe "'checked_at's attributes" do
    it "should have a valid check-in" do
      FactoryGirl.build(:checking, checked_in_at: Time.now).should be_valid
    end
    it "should not have a nil check-in" do
      FactoryGirl.build(:checking, checked_in_at: nil).should_not be_valid
    end
    it "should not have a blank check-in" do
      FactoryGirl.build(:checking, checked_in_at: "").should_not be_valid
    end
    it "should have a valid check-out" do
      FactoryGirl.build(:checking, checked_out_at: Time.now).should be_valid
    end
    it "should have a nil check-out" do
      FactoryGirl.build(:checking, checked_out_at: nil).should be_valid
    end
  end

  it "should not have a nil user id" do
    FactoryGirl.build(:checking, user_id: nil).should_not be_valid
  end
  it "should have a valid user id" do
    FactoryGirl.build(:checking, user_id: 1).should be_valid
  end
  it "should have a 'weekday' method" do
    FactoryGirl.build(:checking).should respond_to :weekday
  end
  it "should have a string returning from 'weekday' method" do
    hour = FactoryGirl.build(:checking)
    hour.weekday(hour.checked_in_at).should be_kind_of String
  end
  it "should have a 'date' method" do
    FactoryGirl.build(:checking).should respond_to :date
  end
  it "should have a string returning from 'date' method" do
    hour = FactoryGirl.build(:checking)
    hour.date(hour.checked_in_at).should be_kind_of String
  end
  it "should have a method to calculate worked hours" do
    FactoryGirl.build(:checking).should respond_to :working_time
  end
  it "should have a string returning from 'working_time' method" do
    hour = FactoryGirl.build(:checking)
    hour.working_time.should be_kind_of String
  end

  describe "scope" do
    it "should return approveds checkings" do
      Checking.should respond_to :approveds
    end
    it "should return not approved checkings" do
      Checking.should respond_to :not_approveds
    end
    it "should return paid checkings" do
      Checking.should respond_to :paids
    end
  end

end
