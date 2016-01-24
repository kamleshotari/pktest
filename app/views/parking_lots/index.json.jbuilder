json.array!(@parking_lots) do |parking_lot|
  json.extract! parking_lot, :id, :floor_level, :slot_no, :distance, :is_allocated
  json.url parking_lot_url(parking_lot, format: :json)
end
