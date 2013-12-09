# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  row        :string(255)
#  number     :integer
#  bus_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Seat < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :bus, touch: true

  validates :row, :number, presence: true

  private
    def defaults
      { row: 'A-Z', number: 0 }
    end
end
