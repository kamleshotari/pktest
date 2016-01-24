json.array!(@parking_details) do |parking_detail|
  json.extract! parking_detail, :id, :parking_lot_id, :reg_no, :color, :is_parked, :in_time, :out_time, :ticket
  json.url parking_detail_url(parking_detail, format: :json)
end
