# == Schema Information
#
# Table name: vouchers
#
#  id         :integer          not null, primary key
#  ref_no     :character varyin
#  amount     :numeric
#  active     :boolean          default(TRUE)
#  client_id  :integer
#  created_at :timestamp withou
#  updated_at :timestamp withou
#  user_id    :integer
#
# Indexes
#
#  index_vouchers_on_client_id  (client_id)
#  index_vouchers_on_user_id    (user_id)
#

class Voucher < ActiveRecord::Base
  default_scope { where(active: true) }

  belongs_to :client, touch: true
  belongs_to :user

  before_create :generate_reference_no

  protected

  def generate_reference_no
    self.ref_no = SecureRandom.hex(4)
  end
end
