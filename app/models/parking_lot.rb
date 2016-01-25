class ParkingLot < ActiveRecord::Base

  has_many :parking_details

  attr_accessor :pk_lots

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

  def self.create_parking_lot_using_command(params)
    if params[:parking_lot][:pk_lots].present?
      pk_lot_details = params[:parking_lot][:pk_lots].split(" ")
      if pk_lot_details.present? && pk_lot_details[0] == "create_parking_lot" && pk_lot_details[1].to_i > 0
        pk_lot_details[1].to_i.times do |p|
          last_lot = ParkingLot.last
          if last_lot.present?
            ParkingLot.create(:floor_level => 1, :slot_no => last_lot.slot_no + 1, :distance => last_lot.distance + 1)
          else
            ParkingLot.create(:floor_level => 1, :slot_no => (p+1), :distance => (p+1))
          end
        end
      end
    end

  end


            
end
