class ParkingLotsController < ApplicationController
  before_action :set_parking_lot, only: [:show, :edit, :update, :destroy]

  def index
    @parking_lots = ParkingLot.all
  end

  def new
    @parking_lot = ParkingLot.new
  end


  def create
    @parking_lot = ParkingLot.new(parking_lot_params)
    if params[:parking_lot][:pk_lots].present?
      ParkingLot.create_parking_lot_using_command(params)
      respond_to do |format|
        format.html { redirect_to parking_lots_url, notice: "Created a parking lot with #{params[:parking_lot][:pk_lots].split(' ').last} slots" }
      end
    else
      respond_to do |format|
        if @parking_lot.save
          format.html { redirect_to @parking_lot, notice: 'Parking lot was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking_lot
      @parking_lot = ParkingLot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_lot_params
      params.require(:parking_lot).permit(:floor_level, :slot_no, :distance, :is_allocated, :pk_lots)
    end
end
