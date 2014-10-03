# == Schema Information
#
# Table name: banks
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require 'rails_helper'

describe Bank, type: :model do

  it { is_expected.to validate_presence_of(:name) }
end
