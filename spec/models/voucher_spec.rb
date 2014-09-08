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

require 'rails_helper'

describe Voucher, :type => :model do

  it { is_expected.to belong_to(:client).touch(true) }
  it { is_expected.to belong_to(:user) }

  describe 'callbacks' do
    it { is_expected.to callback(:generate_reference_no).before(:create) }

    describe '#generate_reference_no' do
      it 'generates a new random reference' do
        voucher = build_stubbed(:voucher, ref_no: nil)
        voucher.send(:generate_reference_no)
        expect(voucher.ref_no).to_not be_nil
      end
    end
  end


end
