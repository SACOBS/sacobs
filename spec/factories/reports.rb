# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  criteria   :hstore           default(""), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :report do
    name "MyString"
criteria ""
  end

end
