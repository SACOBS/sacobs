# == Schema Information
#
# Table name: clients
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  surname       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  home_no       :string(255)
#  cell_no       :string(255)
#  email         :string(255)
#  slug          :string(255)
#  user_id       :integer
#  full_name     :string(255)
#  high_risk     :boolean          default(FALSE)
#  bank_id       :integer
#  work_no       :string(255)
#  date_of_birth :date
#  title         :string(255)
#  notes         :text
#  id_number     :string(255)
#
# Indexes
#
#  index_clients_on_bank_id  (bank_id)
#  index_clients_on_slug     (slug) UNIQUE
#  index_clients_on_user_id  (user_id)
#

require 'rails_helper'

describe Client, :type => :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:bank) }
  it { is_expected.to have_one(:address).dependent(:destroy) }
  it { is_expected.to have_many(:bookings).dependent(:destroy) }
  it { is_expected.to have_many(:vouchers).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:address).allow_destroy(true) }


  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:surname) }

  describe 'delegation' do
    it { is_expected.to delegate_method(:bank_name).to(:bank).as(:name) }
    it { is_expected.to delegate_method(:street_address1).to(:address) }
    it { is_expected.to delegate_method(:street_address2).to(:address) }
    it { is_expected.to delegate_method(:postal_code).to(:address) }
    it { is_expected.to delegate_method(:city).to(:address) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:init_address).after(:initialize) }
    it { is_expected.to callback(:set_full_name).before(:validation) }

    describe '#init_address' do
        it 'builds a new address' do
          client = build_stubbed(:client, address: nil)
          client.send(:init_address)
          expect(client.address).to be_new_record
        end
    end

    describe '#set_full_name' do
      it 'sets the full_name of the client from the name and surname' do
        client = build_stubbed(:client, name: 'Jim', surname: 'Johnson')
        client.send(:set_full_name)
        expect(client.full_name).to eq('Jim Johnson')
      end
    end
  end


  describe 'instance methods' do
    describe '#age' do
      context 'date of birth is present' do
        it 'returns the clients age' do
          client = build_stubbed(:client, date_of_birth: Date.today - 10.years)
          expect(client.age).to eq(10)
        end
      end
      context 'date of birth is not present' do
        it 'returns a nil value for age' do
          client = build_stubbed(:client)
          expect(client.age).to be_nil
        end
      end
    end
  end
end
