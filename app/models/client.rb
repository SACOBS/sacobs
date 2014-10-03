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
#  id_number     :string(255)
#
# Indexes
#
#  index_clients_on_bank_id  (bank_id)
#  index_clients_on_slug     (slug) UNIQUE
#  index_clients_on_user_id  (user_id)
#

class Client < ActiveRecord::Base
  extend FriendlyId

  TITLES = [:Mr, :Mrs, :Dr, :Miss].freeze

  belongs_to :user
  belongs_to :bank

  has_one :address, as: :addressable, dependent: :delete

  with_options dependent: :delete_all do |assoc|
    assoc.has_many :bookings
    assoc.has_many :vouchers
  end

  accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true

  delegate :street_address1, :street_address2, :city, :postal_code, to: :address, prefix: false, allow_nil: true
  delegate :name, to: :bank, prefix: true, allow_nil: true

  friendly_id :full_name, use: :slugged

  validates :name, :surname, presence: true

  before_validation :set_full_name, prepend: true
  before_save :set_birth_date_from_id_number

  def address
    address ||= build_address
  end

  def age
    return unless date_of_birth?
    @age ||= date_of_birth.find_age
  end

  def is_pensioner?
    id_number? && age >= 65
  end

  protected

  def set_birth_date_from_id_number
    self.date_of_birth = Date.strptime(id_number[0..5], '%y%m%d') if id_number?
  end

  def set_full_name
    self.full_name = "#{name} #{surname}"  if name_changed? || surname_changed?
  end

  def should_generate_new_friendly_id?
    full_name_changed?
  end
end
