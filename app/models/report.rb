# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  criteria   :json             default("{}"), not null
#  period     :integer          default("3")
#

class Report < ActiveRecord::Base
end
