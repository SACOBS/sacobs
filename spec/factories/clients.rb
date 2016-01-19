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

FactoryGirl.define do
  factory :client do
    name "Paul"
    surname "JvR"
  end
end
