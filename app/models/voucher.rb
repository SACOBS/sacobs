# == Schema Information
#
# Table name: vouchers
#
#  id         :integer          not null, primary key
#  ref_no     :string(255)
#  amount     :decimal(, )
#  active     :boolean          default(TRUE)
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Voucher < ActiveRecord::Base
  default_scope -> { where(active: true) }

  belongs_to :client
  belongs_to :user

  before_create :generate_reference_no

  protected
   def generate_reference_no
     self.ref_no = SecureRandom.hex(4)
   end
end
