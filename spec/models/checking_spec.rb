require 'spec_helper'

describe Checking do
  let! :checking do
    FactoryGirl.build(:checking)
  end

  let! :predefined_checking do
    FactoryGirl.build(:predefined_checking)
  end

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

  describe "working time" do
    it "should have a method to show (not calculate) worked hours" do
      FactoryGirl.build(:checking).should respond_to :working_time
    end

    it "should return nil if no valid check in informed" do
      predefined_checking.checked_in_at = nil
      predefined_checking.working_time.should be_nil
    end

    it "should return nil if no valid check out informed" do
      predefined_checking.checked_out_at = nil
      predefined_checking.working_time.should be_nil
    end

    it "should have a string returning from 'working_time' method when not on clock style mode" do
      predefined_checking.working_time.should == "2h 41m"
    end

    it "should have a string returning from 'working_time' method when on clock style mode" do
      predefined_checking.working_time(true).should == "02:41"
    end

    it "should return just the hour" do
      predefined_checking.checked_out_at = "2013-09-04 14:00:00"
      predefined_checking.working_time.should == "2h"
    end

    it "should return just the minute" do
      predefined_checking.checked_out_at = "2013-09-04 12:10:00"
      predefined_checking.working_time.should == "10m"
    end
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

  describe "time tokens" do
    it "should have a method to return them" do
      checking.should respond_to :time_difference
    end

    it "should return nil if checked in is empty" do
      checking.checked_in_at = nil
      checking.time_difference.should be_nil
    end

    it "should return nil if checked out is empty" do
      checking.checked_out_at = nil
      checking.time_difference.should be_nil
    end

    it "should return the correct values if filled" do
      tokens = predefined_checking.time_difference
      tokens.should_not be_nil
      tokens[:hour].should be_equal 2
      tokens[:minute].should be_equal 41
    end
  end

  describe "set value" do
    it "should set the correct value when no value specified and hour value present" do
      predefined_checking.hour_value = 10
      predefined_checking.set_value
      predefined_checking.value.round.to_s.should == "27"
    end

    it "should set the correct value when value specified and no hour value present" do
      predefined_checking.hour_value = nil
      predefined_checking.set_value(20)
      predefined_checking.value.round.to_s.should == "54"
    end

    it "should set the correct value when no value specified and no hour value present" do
      predefined_checking.hour_value = nil
      predefined_checking.set_value
      predefined_checking.value.to_s.should == "0.0"
    end
  end
end
