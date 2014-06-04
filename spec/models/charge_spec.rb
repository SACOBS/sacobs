require 'rails_helper'

describe Charge, :type => :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:percentage) }
end
