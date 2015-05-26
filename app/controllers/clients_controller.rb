class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  after_action :verify_policy_scoped, only: [:index, :search]
  after_action :verify_authorized, except: [:index, :search]

  def index
    @clients = client_scope.surname_starts_with(params[:letter]).order(:surname).page(params[:page])
    if stale?(@clients)
     respond_with(@clients)
    end
  end

  def search
    @search = client_scope.search(params[:q])
    @results = @search.result.limit(50)
  end

  def show
    authorize :client
    fresh_when @client, last_modified: @client.updated_at
  end

  def new
    authorize :client
    @client = Client.new
  end

  def create
    authorize :client
    @client = Client.create(client_params)
    respond_with @client
  end

  def edit
    authorize :client
  end

  def update
    authorize :client
    @client.update(client_params)
    respond_with @client
  end

  def destroy
    authorize :client
    @client.destroy
    respond_with @client
  end

  private

  def client_scope
    policy_scope(Client)
  end

  def set_client
    @client = client_scope.find(params[:id])
  end

  def client_params
    params.fetch(:client, {}).permit(:title,
                                     :name,
                                     :surname,
                                     :date_of_birth,
                                     :high_risk,
                                     :cell_no,
                                     :home_no,
                                     :work_no,
                                     :email,
                                     :bank,
                                     :notes,
                                     :id_number,
                                     :street_address1,
                                     :street_address2,
                                     :city,
                                     :postal_code).merge(user_id: current_user.id)
  end

  def interpolation_options
    { resource_name: @client.full_name }
  end
end
