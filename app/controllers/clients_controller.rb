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

class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.search(surname_start: params[:letter] ||= 'A').result.page(params[:page])
    respond_with(@clients) if stale?(@clients)
  end

  def download
    @clients = Client.all
    render xlsx: 'clients'
  end

  def search
    @search = Client.search(params[:q])
    @clients = @search.result.limit(50)
  end

  def show
    respond_with(@client) do |format|
      format.html { fresh_when @client }
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.create(client_params)
    respond_with @client
  end

  def update
    @client.update(client_params)
    respond_with @client
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:title, :name,
                                   :surname, :date_of_birth,
                                   :high_risk, :cell_no,
                                   :home_no, :work_no,
                                   :email, :bank,
                                   :notes, :id_number,
                                   :street_address1, :street_address2,
                                   :city, :postal_code).merge(user_id: current_user.id)
  end

  def interpolation_options
    { resource_name: @client.full_name }
  end
end
