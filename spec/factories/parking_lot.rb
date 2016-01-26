require 'faker'

FactoryGirl.define do
  factory :parking_lot do |f|
    f.floor_level { Faker::Number.number(1) }
    f.slot_no { Faker::Number.number(1) }
    f.distance {Faker::Number.decimal(1)}
  end
end