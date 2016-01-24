require 'test_helper'

class ParkingDetailsControllerTest < ActionController::TestCase
  setup do
    @parking_detail = parking_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parking_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parking_detail" do
    assert_difference('ParkingDetail.count') do
      post :create, parking_detail: { color: @parking_detail.color, in_time: @parking_detail.in_time, is_parked: @parking_detail.is_parked, out_time: @parking_detail.out_time, parking_lot_id: @parking_detail.parking_lot_id, reg_no: @parking_detail.reg_no, ticket: @parking_detail.ticket }
    end

    assert_redirected_to parking_detail_path(assigns(:parking_detail))
  end

  test "should show parking_detail" do
    get :show, id: @parking_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parking_detail
    assert_response :success
  end

  test "should update parking_detail" do
    patch :update, id: @parking_detail, parking_detail: { color: @parking_detail.color, in_time: @parking_detail.in_time, is_parked: @parking_detail.is_parked, out_time: @parking_detail.out_time, parking_lot_id: @parking_detail.parking_lot_id, reg_no: @parking_detail.reg_no, ticket: @parking_detail.ticket }
    assert_redirected_to parking_detail_path(assigns(:parking_detail))
  end

  test "should destroy parking_detail" do
    assert_difference('ParkingDetail.count', -1) do
      delete :destroy, id: @parking_detail
    end

    assert_redirected_to parking_details_path
  end
end
