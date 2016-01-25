class ParkingDetail < ActiveRecord::Base

  belongs_to :parking_lot

  attr_accessor :pk_detail

  validates :reg_no, :presence => true,
  			:format => {:with => /[A-Z]{2}[-][0-9]{2}[-][A-Z]{2}[-][0-9]{4}/i ,
  			:message => "Please enter valid registration no."}
  validates :color, :presence => true

  validates :ticket, :presence => true,
  					:uniqueness => true

  validates :parking_lot_id, :presence => true

  
  before_validation :assign_slot_for_parking, :on => :create
  after_save :set_allocation, :de_allocation

  
  def assign_slot_for_parking
  	slot = ParkingLot.get_available_slot
  	if slot.present?
  		self.parking_lot_id = slot.id
  		self.is_parked = true
  		self.ticket = self.generate_ticket
  		self.in_time = Time.now
    else
      self.errors.add(:base, "Sorry, parking lot is full")
  	end
  end

  def set_allocation
  	if self.is_parked == true
  		self.parking_lot.update_attribute(:is_allocated, true)
  	end
  end

  def de_allocation
  	if self.is_parked == false
  		self.parking_lot.update_attribute(:is_allocated, false)
  	end
  end

  def generate_ticket
  	(Time.now.to_f.round(3)*1000).to_i.to_s
  end

  def self.book_parking_using_command(params)
    if params[:parking_detail][:pk_detail].present?
      parking_detail = params[:parking_detail][:pk_detail].split(" ")
      if parking_detail.count == 3 && parking_detail[0] == "park"
        return parking_detail
      else
        return nil
      end
    end
  end


  def self.search(params)
    if params[:s].present?
      search_option = params[:s].split(" ")
      case search_option[0]
      when "registration_numbers_for_cars_with_colour"
        parking_details = ParkingDetail.where('color = ?', search_option[1])
      when "slot_numbers_for_cars_with_colour"
        parking_details = ParkingDetail.where('color = ?', search_option[1])
      when "slot_number_for_registration_number"
        parking_details = ParkingDetail.where('reg_no = ?', search_option[1])
      else
        parking_details = nil
      end
      parking_details      
    end
  end

end
