require 'rails_helper'

describe ParkingLot do
  it "has a valid factory" do
  	FactoryGirl.create(:parking_lot).should be_valid
  end
  it "is invalid without a slot_no" do
  	FactoryGirl.build(:parking_lot, :slot_no => nil).should_not be_valid
  end
  it "is invalid without a distance" do
  	FactoryGirl.build(:parking_lot, :distance => nil).should_not be_valid
  end
end