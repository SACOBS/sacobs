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
#
# Indexes
#
#  index_clients_on_bank_id  (bank_id)
#  index_clients_on_slug     (slug) UNIQUE
#  index_clients_on_user_id  (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    name "MyString"
    surname "MyString"
  end
end
