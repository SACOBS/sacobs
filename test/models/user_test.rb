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
#  role                   :integer          default(0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:surname)

  test 'normalizes the name and surname before saving' do
    user = User.new(name: 'Tom  ', surname: ' Smith', email: 'tom@example.com', password: default_password)

    user.save

    assert_equal 'TOM', user.name
    assert_equal 'SMITH', user.surname
  end

  test '#full_name' do
    user = users(:paul)
    assert_equal "#{user.name} #{user.surname}", user.full_name
  end
end
