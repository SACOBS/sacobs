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