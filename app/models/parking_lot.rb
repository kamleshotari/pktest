class ParkingLot < ActiveRecord::Base

  has_many :parking_details

  validates :floor_level, :presence => true,
            :numericality => true

  validates :slot_no, :presence => true,
            :numericality => true,
            :uniqueness => {:scope => :floor_level} 

  validates :distance, :presence => true,
            :numericality => true,
            :uniqueness => {:scope => :floor_level} 




  def self.get_available_slot
    parking_lot = ParkingLot.where("is_allocated = ? OR is_allocated is NULL", false).order('slot_no', 'distance').first
  end


            
end
