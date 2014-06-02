require 'spec_helper'

describe Invoice, :type => :model do

  it { is_expected.to belong_to(:booking) }
  it { is_expected.to have_many(:line_items).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:line_items)}


  describe 'instance methods' do
    let(:debit_item){ create(:line_item, amount: 100, line_item_type: :debit) }
    let(:credit_item){ create(:line_item, amount: 100, line_item_type: :credit) }
    let(:invoice){ create(:invoice, line_items: [debit_item, credit_item]) }

    describe '#total' do
      it 'returns the difference between the debits and credits' do
       expected = debit_item.amount - credit_item.amount
       expect(invoice.total).to eq(expected)
      end
    end

    describe '#total_cost' do
      it 'sums the debits' do
        expected = debit_item.amount
        expect(invoice.total_cost).to eq(expected)
      end
    end

    describe '#total_discount' do
      it 'sums the credits' do
        expected = credit_item.amount
        expect(invoice.total_discount).to eq(expected)
      end
    end

  end

end