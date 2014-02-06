# == Schema Information
#
# Table name: payment_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class PaymentType < ActiveRecord::Base
end
