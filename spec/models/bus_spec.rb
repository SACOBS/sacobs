# == Schema Information
#
# Table name: buses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  capacity   :integer
#  year       :string(255)
#  model      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Bus do
  let(:bus) { build(:bus) }
  subject { bus }

  it { should be_valid }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:capacity) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:model) }

end
