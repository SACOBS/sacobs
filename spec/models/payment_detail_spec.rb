require 'spec_helper'

describe PaymentDetail, :type => :model do
  it { is_expected.to belong_to(:payment_type) }
  it { is_expected.to belong_to(:booking).touch(true) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:payment_type) }

  it { is_expected.to delegate_method(:payment_type_description).to(:payment_type).as(:description) }

end