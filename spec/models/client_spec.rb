# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  tel_no     :string(255)
#  cell_no    :string(255)
#  email      :string(255)
#  slug       :string(255)
#  user_id    :integer
#

require 'spec_helper'

describe Client do
  pending "add some examples to (or delete) #{__FILE__}"
end
