require 'rails_helper'

describe "POST create" do
  context "with valid attributes" do
    it "creates a new parking_lot" do
      expect{
        FactoryGirl.create(:parking_lot)
      }.to change(ParkingLot,:count).by(1)
    end
  end
  
  context "with invalid attributes" do
    it "does not save the new parking_lot" do
      expect{
        FactoryGirl.build(:parking_lot, :slot_no => nil)
      }.to_not change(ParkingLot,:count)
    end
  end
end