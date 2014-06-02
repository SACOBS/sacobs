require 'spec_helper'

describe PaymentDetail do
  it { should belong_to(:payment_type) }
  it { should belong_to(:booking).touch(true) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:payment_type) }

  it { should delegate_method(:payment_type_description).to(:payment_type).as(:description) }

end