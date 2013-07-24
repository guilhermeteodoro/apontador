require "spec_helper"

describe Person do
  before (:each) do
    @valid_attributes = {

    }
  end
  it "should have a valid factory" do
    FactoryGirl.create(:person)
  end
  it "should create an instance of Person"

  end
  it "should have a first name" do
    wrong = FactoryGirl.build(:person, first_name: nil)
    wrong.should_not be_valid
  end
end
