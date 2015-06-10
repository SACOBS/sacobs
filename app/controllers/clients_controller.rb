class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.surname_starts_with(params[:letter] || 'A').order(:surname).page(params[:page]).select(:id, :name, :surname, :home_no, :work_no, :cell_no, :email, :updated_at)

    if request.xhr?
      render partial: 'clients', locals: { clients: @clients }
    else
      render :index
    end
  end

  def search
    @search = Client.search(params[:q])
    @clients = @search.result.limit(50)
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
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.js { head :no_content }
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
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
