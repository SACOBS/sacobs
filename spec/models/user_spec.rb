# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  surname                :string(255)
#  role                   :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

describe User, type: :model do

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
