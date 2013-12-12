class ClientsController < ApplicationController
  before_action :set_client, only: [:edit, :update, :destroy]

  params_for :client, :name, :surname, :cell_no, :tel_no, :email ,address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy]

  def index
    @q = Client.search(params[:q])
    @clients = @q.result(distinct: true).decorate
  end

  def show
    @client = Client.friendly.find(params[:id]).decorate
  end

  # GET /clients/new
  def new
    @client = Client.new
    @client.build_address
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.create(client_params)
    respond_with @client
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    @client.update(client_params)
    respond_with @client
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_with @client
  end

  private
    def set_client
      @client = Client.friendly.find(params[:id])
    end

    def interpolation_options
      { resource_name: @client.full_name }
    end
end
