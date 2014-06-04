require 'rails_helper'

describe User, :type => :model do

  describe 'class methods' do
    describe '.all_except' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }

      it 'returns all users except the one passed in' do

        another_user = create(:user)
        result = User.all_except(user)
        expect(result).to eq [another_user]
      end
    end
  end

  describe 'instance methods' do
    describe '#to_s' do
      it 'returns the concatenated name and surname titleized' do
        user = build_stubbed(:user, name: 'jim', surname: 'johnson')
        result = user.to_s
        expect(result).to eq('Jim Johnson')
      end
    end
  end
end