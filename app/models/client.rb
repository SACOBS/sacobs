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
  default_scope { order(:surname) }

  PENSIONER_AGE = 65

  TITLES = %i(Mr Mrs Dr Miss Professor Master).freeze
  BANKS = %i(Absa StandardBank Nedbank Capitec FNB Investec Cash).freeze

  attr_reader :age, :full_name

  to_param :full_name

  has_many :bookings, -> { available.completed }
  has_many :vouchers

  validates :name, :surname, presence: true
  validates :surname, uniqueness: {scope: :name, message: "and name already exists"}
  validates :date_of_birth, presence: {message: "obtained from id number is not a valid date, please check the id number field."}, if: :id_number?

  before_validation :set_birth_date, if: :id_number?
  before_save :normalize

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new("||", Arel::Nodes::InfixOperation.new("||", parent.table[:name], Arel::Nodes.build_quoted(" ")), parent.table[:surname])
  end

  scope :surname_starts_with, ->(letter) { where(arel_table[:surname].matches("#{letter}%")) }

  def age
    @age ||= ((Date.current - date_of_birth).to_i / 365.25).floor if date_of_birth?
  end

  def is_pensioner?
    age&.>= PENSIONER_AGE
  end

  def full_name
    @full_name ||= "#{name} #{surname}"
  end

  protected

  def normalize
    self.name = name.squish.upcase
    self.surname = surname.squish.upcase
  end

  def set_birth_date
    date = begin
             Date.strptime(id_number[0..5], "%y%m%d")
           rescue
             nil
           end
    self.date_of_birth = (date&.> Date.current) ? date.prev_year(100) : date
  end
end
