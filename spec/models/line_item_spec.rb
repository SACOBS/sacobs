require 'rails_helper'

describe LineItem, :type => :model do
  it { is_expected.to belong_to(:invoice) }
end