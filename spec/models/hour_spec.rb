require 'spec_helper'

describe Hour do
  it "should have a valid factory" do
    FactoryGirl.build(:hour).should be_valid
  end

  # 'checked_at's attributes
  it "should have a valid check-in" do
    FactoryGirl.build(:hour, checked_in_at: Time.now).should be_valid
  end
  it "should have a nil check-in" do
    FactoryGirl.build(:hour, checked_in_at: nil).should_not be_valid
  end
  it "should have a blank check-in" do
    FactoryGirl.build(:hour, checked_in_at: "").should_not be_valid
  end
  it "should have a valid check-out" do
    FactoryGirl.build(:hour, checked_out_at: Time.now).should be_valid
  end
  it "should have a nil check-out" do
    FactoryGirl.build(:hour, checked_out_at: nil).should_not be_valid
  end
  it "should have a blank check-out" do
    FactoryGirl.build(:hour, checked_out_at: "").should_not be_valid
  end

  it "should not have a nil person id" do
    FactoryGirl.build(:hour, person_id: nil).should_not be_valid
  end
  it "should have a valid person id" do
    FactoryGirl.build(:hour, person_id: 1).should be_valid
  end
  it "should have a 'weekday' method" do
    FactoryGirl.build(:hour).should respond_to :weekday
  end
  it "should have a string returning from 'weekday' method" do
    hour = FactoryGirl.build(:hour)
    hour.weekday(hour.checked_in_at).should be_kind_of String
  end
  it "should have a 'date' method" do
    FactoryGirl.build(:hour).should respond_to :date
  end
  it "should have a string returning from 'date' method" do
    hour = FactoryGirl.build(:hour)
    hour.date(hour.checked_in_at).should be_kind_of String
  end
  it "should have a method to calculate worked hours" do
    FactoryGirl.build(:hour).should respond_to :worktime
  end
  it "should have a string returning from 'worktime' method" do
    hour = FactoryGirl.build(:hour)
    hour.worktime.should be_kind_of String
  end
end
