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
#  user_id       :integer
#  high_risk     :boolean          default(FALSE)
#  work_no       :string(255)
#  date_of_birth :date
#  title         :string(255)
#  notes         :text
#  id_number     :string(255)
#  bank          :string(255)
#
# Indexes
#
#  index_clients_on_name_and_surname  (name,surname) UNIQUE
#  index_clients_on_user_id           (user_id)
#

class Client < ActiveRecord::Base
  PENSIONER_AGE = 65
  TITLES = [:Mr, :Mrs, :Dr, :Miss, :Professor, :Master].freeze
  BANKS = [:Absa, :StandardBank, :Nedbank, :Capitec, :FNB, :Investec].freeze

  attr_reader :age, :full_name

  to_param :full_name

  has_one :address, as: :addressable, dependent: :delete
  has_many :bookings
  has_many :vouchers, dependent: :delete_all

  delegate :street_address1, :street_address2, :city, :postal_code, to: :address, prefix: false, allow_nil: true

  accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true

  validates :name, :surname, presence: true
  validates :surname, uniqueness: { scope: :name, message: 'and name already exists' }

  before_validation :normalize
  before_save :set_birth_date

  scope :surname_starts_with, ->(letter) { where(arel_table[:surname].matches("#{letter}%")) }


  def age
    @age ||= ((Date.today - date_of_birth).to_i / 365.25).floor if date_of_birth.present?
  end

  def is_pensioner?
   return unless age.present?
   age >= PENSIONER_AGE
  end

  def full_name
   @full_name ||= "#{name} #{surname}"
  end

  protected

  def set_birth_date
    return unless id_number.present? && id_number.size > 5
    date = Date.strptime(id_number[0..5], '%y%m%d')
    date.prev_year(100) if date > Date.today
    self.date_of_birth = date
  end

  def normalize
    name.try(:squish!).try(:upcase!)
    surname.try(:squish!).try(:upcase!)
    email.try(:squish!).try(:downcase!)
  end
end
