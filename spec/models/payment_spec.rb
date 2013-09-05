require 'spec_helper'

describe Payment do
  let :payment do
    FactoryGirl.create :payment
  end

  it "should have a valid factory" do
    FactoryGirl.build(:payment).should be_valid
  end

  describe "attributes validations" do
    it "should have a valid token" do
      #
      (FactoryGirl.create :payment).should be_valid
    end

  end

end
