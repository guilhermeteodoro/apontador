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
      payment.token.should_not eql nil
    end
    it "should have a valid 'concluded'" do
      payment.concluded.should_not eql nil
    end
  end

  describe "token" do
    it "should be defined just once" do
      token = payment.token
      payment.token = "something"
      payment.token.should eql token

      #teste de object_id
      id = payment.token.object_id
      payment.token = "something"
      payment.token.object_id.should eql id
    end
    it "should have a 20 caracters length" do
      payment.token.length.should eql 20
    end
  end

  describe "token generator" do
    it "should have a method to generate tokens" do
      Payment.should respond_to :token_generator
    end
    it "should have a string returning a 20 caracters length token" do
      Payment.token_generator.length.should eql 20
    end
  end

end
