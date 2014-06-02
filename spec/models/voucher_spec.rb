require 'spec_helper'

describe Voucher do

  it { should belong_to(:client).touch(true) }
  it { should belong_to(:user) }

  describe 'callbacks' do
    it { should callback(:generate_reference_no).before(:create) }

    describe '#generate_reference_no' do
      it 'generates a new random reference' do
        voucher = build_stubbed(:voucher, ref_no: nil)
        voucher.send(:generate_reference_no)
        expect(voucher.ref_no).to_not be_nil
      end
    end
  end


end