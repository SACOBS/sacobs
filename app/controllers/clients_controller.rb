class ClientsController < ApplicationController
  before_action :set_client, only: [:contact_details, :show, :edit, :update, :destroy]
  decorates_assigned :client
  decorates_assigned :clients


  def index
    @q = Client.includes(:user).search(params[:q])
    @clients = @q.result(distinct: true).page(params[:page])
    fresh_when(etag: CacheHelper.cache_key_for_collection(@clients, CacheHelper.build_cache_key_from_ransack_search(@q)))
  end

  def show
    fresh_when @client, last_modified: @client.updated_at
  end

  def contact_details
    fresh_when @client, last_modified: @client.updated_at
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

    def client_params
      ClientParameters.new(params).permit(user: current_user)
    end

    def interpolation_options
      { resource_name: @client.full_name }
    end
end
