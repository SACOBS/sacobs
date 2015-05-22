# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :character varyin default(""), not null
#  encrypted_password     :character varyin default(""), not null
#  reset_password_token   :character varyin
#  reset_password_sent_at :timestamp withou
#  remember_created_at    :timestamp withou
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :timestamp withou
#  last_sign_in_at        :timestamp withou
#  current_sign_in_ip     :character varyin
#  last_sign_in_ip        :character varyin
#  created_at             :timestamp withou
#  updated_at             :timestamp withou
#  name                   :character varyin
#  surname                :character varyin
#  role                   :integer          default(0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:clerk, :admin]

  has_many :bookings

  scope :all_except, ->(user) { where.not(id: user) }

  def to_s
    "#{name} #{surname}".titleize
  end
end
