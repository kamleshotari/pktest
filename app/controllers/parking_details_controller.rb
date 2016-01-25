class ParkingDetailsController < ApplicationController
  before_action :set_parking_detail, only: [:show, :edit, :update, :destroy, :return_parking_ticket]

  # GET /parking_details
  # GET /parking_details.json
  def index
    if params[:s].present?
      @parking_details = ParkingDetail.search(params)
    else
      @parking_details = ParkingDetail.all
    end
  end

  # GET /parking_details/1
  # GET /parking_details/1.json
  def show
  end

  # GET /parking_details/new
  def new
    @parking_detail = ParkingDetail.new
  end

  # GET /parking_details/1/edit
  def edit
  end

  # POST /parking_details
  # POST /parking_details.json
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
        format.html { redirect_to @parking_detail, notice: 'Parking detail was successfully created.' }
        format.json { render :show, status: :created, location: @parking_detail }
      else
        format.html { render :new }
        format.json { render json: @parking_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parking_details/1
  # PATCH/PUT /parking_details/1.json
  def update
    respond_to do |format|
      if @parking_detail.update(parking_detail_params)
        format.html { redirect_to @parking_detail, notice: 'Parking detail was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /parking_details/1
  # DELETE /parking_details/1.json
  def destroy
    @parking_detail.destroy
    respond_to do |format|
      format.html { redirect_to parking_details_url, notice: 'Parking detail was successfully destroyed.' }
      format.json { head :no_content }
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
