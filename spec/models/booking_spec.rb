require 'spec_helper'

describe Booking do

  it { should belong_to(:user) }
  it { should belong_to(:trip) }
  it { should belong_to(:stop) }
  it { should belong_to(:client) }
  it { should belong_to(:main).conditions('where status != cancelled').class_name('Booking').with_foreign_key(:main_id).touch(true) }

  it { should have_one(:return_booking).conditions('where status != cancelled').class_name('Booking').with_foreign_key(:main_id) }
  it { should have_one(:invoice).dependent(:destroy) }
  it { should have_one(:payment_detail).dependent(:destroy) }

  it { should have_many(:passengers).dependent(:destroy) }


  it { should accept_nested_attributes_for(:client) }
  it { should accept_nested_attributes_for(:passengers) }
  it { should accept_nested_attributes_for(:invoice) }
  it { should accept_nested_attributes_for(:return_booking) }

  #it { should delegate_method(:name).to(:trip) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }


end
