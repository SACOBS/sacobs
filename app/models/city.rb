# == Schema Information
#
# Table name: cities
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  user_id      :integer
#  venues_count :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_cities_on_name     (name)
#  index_cities_on_user_id  (user_id)
#

class City < ActiveRecord::Base
  include CollectionCacheable

  default_scope { order(name: :asc) }

  to_param :name

  has_many :time_tables, dependent: :delete_all
  has_many :venues, dependent: :delete_all

  accepts_nested_attributes_for :venues, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :time_tables

  validates :name, presence: true

  before_save :format_name

  def outgoing_time_table
    time_tables.outgoing.first
  end

  def incoming_time_table
    time_tables.incoming.first
  end



  protected

  def format_name
    self.name = name.squish.upcase
  end
end
