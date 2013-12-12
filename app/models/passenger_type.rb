# == Schema Information
#
# Table name: passenger_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class PassengerType < ActiveRecord::Base
  validates :description, presence: true

  before_create :format_description

  protected
   def format_description
     self.description.downcase!
   end
end
