# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class City < ActiveRecord::Base
  validates :name, presence: true
end
