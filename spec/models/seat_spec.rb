require 'spec_helper'

describe Seat do

  it { should belong_to(:bus).touch(true) }
  it { should validate_presence_of(:row) }
  it { should validate_presence_of(:number) }
  it { should validate_numericality_of(:number) }



end