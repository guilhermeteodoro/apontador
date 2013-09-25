require "spec_helper"

describe Task do

  describe "assignment" do
    it "doesn't throw exception" do
      expect{
        Task.create!(
          name: "Name",
          description: "Description!"
        )}.to_not raise_error
    end
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

end