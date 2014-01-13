# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#  user_id    :integer
#
# Indexes
#
#  index_drivers_on_slug     (slug) UNIQUE
#  index_drivers_on_user_id  (user_id)
#

require 'spec_helper'

describe Driver do
  pending "add some examples to (or delete) #{__FILE__}"
end
