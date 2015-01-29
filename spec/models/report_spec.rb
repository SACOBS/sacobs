# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  criteria   :hstore           default(""), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Report, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
