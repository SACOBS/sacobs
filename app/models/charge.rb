class Charge < ActiveRecord::Base
  belongs_to :passenger_type
  belongs_to :user
  accepts_nested_attributes_for :passenger_type, reject_if: :all_blank, allow_destroy: true
end
