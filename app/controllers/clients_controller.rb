class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    if request.xhr?
      @clients = client_scope.surname_starts_with(params[:letter]).order(:surname).page(params[:page])
      if stale?(@clients)
       render partial: 'clients', locals: { clients: @clients }
      end
    end
  end

  def search
    @search = client_scope.search(params[:q])
    @results = @search.result.limit(50)
  end

  def show
    fresh_when @client
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
    respond_with @client
  end

  private
  def client_scope
    Client.all
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
