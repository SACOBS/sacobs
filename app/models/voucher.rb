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

  before_create :generate_reference_no

  validates :amount, numericality: { greater_than: 0 }

  protected

  def generate_reference_no
    self.ref_no = SecureRandom.hex(4)
  end
end
