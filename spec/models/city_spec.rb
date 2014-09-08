# == Schema Information
#
# Table name: cities
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  slug         :string(255)
#  user_id      :integer
#  venues_count :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_cities_on_slug     (slug) UNIQUE
#  index_cities_on_user_id  (user_id)
#

require 'rails_helper'

describe City, :type => :model do


  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:venues).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:venues).allow_destroy(true) }
end
