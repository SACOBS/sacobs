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

class Client < ActiveRecord::Base
  PENSIONER_AGE = 65

  TITLES = [:Mr, :Mrs, :Dr, :Miss, :Professor, :Master].freeze
  BANKS = [:Absa, :StandardBank, :Nedbank, :Capitec, :FNB, :Investec, :Cash].freeze

  attr_reader :age, :full_name

  to_param :full_name

  has_many :bookings
  has_many :vouchers, dependent: :delete_all

  validates :name, :surname, presence: true
  validates :surname, uniqueness: { scope: :name, message: 'and name already exists' }
  validates :date_of_birth, presence: { message: 'obtained from id number is not a valid date, please check the id number field.' }, if: proc { |client| client.id_number.present? }

  before_validation :set_birth_date

  def name=(val)
    value.squish!.upcase! if value.present?
    super(value)
  end

  def surname=(val)
    value.squish!.upcase! if value.present?
    super(value)
  end

  def email=(val)
    value.squish!.upcase! if value.present?
    super(value)
  end

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||', Arel::Nodes::InfixOperation.new('||', parent.table[:name], Arel::Nodes.build_quoted(' ')), parent.table[:surname])
  end

  scope :surname_starts_with, ->(letter) { where(arel_table[:surname].matches("#{letter}%")) }

  def age
    @age ||= ((Date.current - date_of_birth).to_i / 365.25).floor if date_of_birth.present?
  end

  def is_pensioner?
    return false unless age.present?
    age >= PENSIONER_AGE
  end

  def full_name
    @full_name ||= "#{name} #{surname}"
  end

  protected

  # Ugly but input is not guaranteed to be valid most of the time
  def set_birth_date
    date = Date.strptime(id_number[0..5], '%y%m%d') rescue nil
    if date
      date = date.prev_year(100) if date > Date.current
      self.date_of_birth = date
    end
  end
end
