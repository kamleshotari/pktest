class ParkingDetail < ActiveRecord::Base

  belongs_to :parking_lot

  attr_accessor :pk_detail

  validates :reg_no, :presence => true,
  			:format => {:with => /[A-Z]{2}[-][0-9]{2}[-][A-Z]{2}[-][0-9]{4}/i ,
  			:message => "Please enter valid registration no."}
  validates :color, :presence => true

  validates :ticket, :presence => true,
  					:uniqueness => true

  
  before_validation :assign_slot_for_parking, :on => :create
  after_save :set_allocation, :de_allocation

  
  def assign_slot_for_parking
  	slot = ParkingLot.get_available_slot
  	if slot.present?
  		self.parking_lot_id = slot.id
  		self.is_parked = true
  		self.ticket = self.generate_ticket
  		self.in_time = Time.now
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

  def book_parking_using_command(params)

  end

end
