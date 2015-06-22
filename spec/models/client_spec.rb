# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  surname         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  home_no         :string(255)
#  cell_no         :string(255)
#  email           :string(255)
#  user_id         :integer
#  high_risk       :boolean          default(FALSE)
#  work_no         :string(255)
#  date_of_birth   :date
#  title           :string(255)
#  notes           :text
#  id_number       :string(255)
#  bank            :string(255)
#  street_address1 :string
#  street_address2 :string
#  city            :string
#  postal_code     :string
#
# Indexes
#
#  index_clients_on_name_and_surname  (name,surname) UNIQUE
#

require 'rails_helper'

RSpec.describe Client, :type => :model do

 it { should have_many(:bookings) }
 it { should have_many(:vouchers).dependent(:delete_all) }

 it { should validate_presence_of(:name) }
 it { should validate_presence_of(:surname) }

 context 'It validates the date of birth when the id number is present' do
   before do
     Client.skip_callback(:validation, :before, :set_birth_date)
   end

   subject { build(:client, id_number: '8112295196088') }
   it { should validate_presence_of(:date_of_birth).with_message(/obtained from id number is not a valid date, please check the id number field./) }

   after do
     Client.set_callback(:validation, :before, :set_birth_date)
   end
 end

 context 'It does not validate the date of birth when the id number is absent' do
   subject { build(:client, id_number: nil) }
   it { should_not validate_presence_of(:date_of_birth) }
 end

 describe 'full_name' do
   it 'should concatenate name and surname' do
     client = build(:client, name: 'Jim', surname: 'Jones')
     expect(client.full_name).to eql('Jim Jones')
   end
 end

 describe 'is_pensioner?' do
   context 'age is 65 or greater' do
     it 'should return true' do
       client = build(:client)
       allow(client).to receive(:age).and_return(65)
       expect(client.is_pensioner?).to be_truthy
     end
   end

   context 'age is less than 65' do
     it 'should return false' do
       client = build(:client)
       allow(client).to receive(:age).and_return(64)
       expect(client.is_pensioner?).to_not be_truthy
     end
   end

 end

 describe 'age' do
   context 'date of birth present' do
     it 'should have an age' do
       client = create(:client, id_number: '8112295178990')
       expect(client.age).to_not be_nil
     end
   end

   context 'date of birth' do
     it 'should have not an age if the date of birth is present' do
       client = create(:client)
       expect(client.age).to be_nil
     end
   end
 end

 describe 'callbacks' do
   describe 'set_birth_date' do
     it 'should set the birth date from id number' do
       client = build(:client, id_number: '8112295189078')
       client.send(:set_birth_date)
       expect(client.date_of_birth).to eq(Date.parse('1981/12/29'))
     end
   end

   describe 'before validation' do
     it 'should run the proper callbacks' do
       client = build(:client)
       expect(client).to receive(:set_birth_date)
       client.run_callbacks(:validation)
     end
   end
 end


end
