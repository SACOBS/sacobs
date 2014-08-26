class ClientsController < ApplicationController
  before_action :set_client, only: [:contact_details, :show, :edit, :update, :destroy]
  after_action :verify_policy_scoped, only: :index
  after_action :verify_authorized, except: :index

  decorates_assigned :client
  decorates_assigned :clients


  def index
    @q = policy_scope(Client).search(search_criteria)
    @clients = @q.result.includes(:address, :user).order(updated_at: :desc).page(params[:page])
    #fresh_when etag: CacheHelper.cache_key_for_collection(@clients)
  end

  def show
    authorize @client
    fresh_when @client, last_modified: @client.updated_at
  end

  def contact_details
    authorize @client, :show?
    fresh_when @client, last_modified: @client.updated_at
  end

  def new
    @client = Client.new
    @client.build_address
    authorize @client
  end

  def create
    @client = Client.new(client_params)
    authorize @client
    @client.save
    respond_with @client
  end

  def edit
    authorize @client
  end

  def update
    authorize @client
    @client.update(client_params)
    respond_with @client
  end

  def destroy
    authorize @client
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

    def search_criteria
      criteria = params.fetch(:q,{})
      criteria.merge! surname_start: params[:letter] if params[:letter]
      criteria
    end

    def interpolation_options
      { resource_name: @client.full_name }
    end
end
