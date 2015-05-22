# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :character varyin
#  surname    :character varyin
#  created_at :timestamp withou
#  updated_at :timestamp withou
#  user_id    :integer
#
# Indexes
#
#  index_drivers_on_user_id  (user_id)
#

class Driver < ActiveRecord::Base
  attr_reader :full_name

  to_param :full_name

  belongs_to :user
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
