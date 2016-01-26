class ParkingDetailsController < ApplicationController
  before_action :set_parking_detail, only: [:show, :edit, :update, :destroy, :return_parking_ticket]


  def index
    if params[:s].present?
      @parking_details = ParkingDetail.search(params)
    else
      @parking_details = ParkingDetail.all
    end
  end


  def show
  end

  def new
    @parking_detail = ParkingDetail.new
  end

  def edit
  end

  def create
    @parking_detail = ParkingDetail.new(parking_detail_params)
    if params[:parking_detail][:pk_detail].present?
      parking_detail = ParkingDetail.book_parking_using_command(params)
      if parking_detail.present?
        @parking_detail.reg_no = parking_detail[1]
        @parking_detail.color = parking_detail[2]
      end
    end
    respond_to do |format|
      if @parking_detail.save
        format.html { redirect_to @parking_detail, notice: "Allocated slot number: #{@parking_detail.parking_lot.slot_no}" }
      else
        format.html { render :new }
      end
    end
  end


  def return_parking_ticket
    @parking_details = ParkingDetail.all
    if @parking_detail.present?
      respond_to do |format|
        if @parking_detail.update_attributes(:is_parked => false, :out_time => Time.now)
          format.js
        else
          p @parking_detail.errors
          format.js
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking_detail
      @parking_detail = ParkingDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_detail_params
      params.require(:parking_detail).permit(:parking_lot_id, :reg_no, :color, :is_parked, :in_time, :out_time, :ticket)
    end
end
