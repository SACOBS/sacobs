require 'spec_helper'

describe User do

  describe 'class methods' do
    describe '.all_except' do
      it 'returns all users except the one passed in' do
        user = create(:user)
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