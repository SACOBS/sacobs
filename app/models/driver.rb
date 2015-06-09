# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Driver < ActiveRecord::Base
  attr_reader :full_name

  to_param :full_name

  has_and_belongs_to_many :trips

  validates :name, :surname, presence: true

  before_save :normalize_names

  def full_name
    @full_name ||= "#{name} #{surname}"
  end

  protected

  def normalize_names
    self.name = name.downcase.squish
    self.surname = surname.downcase.squish
  end
end
