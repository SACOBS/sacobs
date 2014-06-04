require 'rails_helper'

describe Seat, :type => :model do

  it { is_expected.to belong_to(:bus).touch(true) }
  it { is_expected.to validate_presence_of(:row) }
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_numericality_of(:number) }



end