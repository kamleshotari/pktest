class ParkingDetailsController < ApplicationController
  before_action :set_parking_detail, only: [:show, :edit, :update, :destroy]

  # GET /parking_details
  # GET /parking_details.json
  def index
    @parking_details = ParkingDetail.all
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
        format.json { render :show, status: :ok, location: @parking_detail }
      else
        format.html { render :edit }
        format.json { render json: @parking_detail.errors, status: :unprocessable_entity }
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
