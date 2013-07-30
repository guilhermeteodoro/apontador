require 'spec_helper'

describe Company do
  it "should have a valid factory" do
    FactoryGirl.create(:company).should be_valid
  end
end
