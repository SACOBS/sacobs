# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  criteria    :json             default("{}"), not null
#  period      :integer          default("3")
#  period_from :date
#  period_to   :date
#

require 'rails_helper'

RSpec.describe Report, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
