class ClientsController < ApplicationController
  before_action :set_client, only: [:contact_details, :show, :edit, :update, :destroy]
  after_action :verify_policy_scoped, only: [:index, :search]
  after_action :verify_authorized, except: [:index, :search]

  def index
    @clients = client_scope.surname_starts_with(params[:letter]).page(params[:page])
  end

  def search
    results = client_scope.search(params[:q]).result.order(updated_at: :desc).page(params[:page])
    flash[:notice] = "#{view_context.pluralize(results.size, 'Result')} found"
    render partial: 'clients/client_listing', locals: { clients: results }
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

  def client_scope
    policy_scope(Client)
  end

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
