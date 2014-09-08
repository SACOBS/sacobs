class CitiesController < ApplicationController
  responders :collection, :flash

  before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @q = City.search(params[:q])
    @cities = @q.result(distinct: true).page(params[:page])
  end

  def new
    @city = City.new
  end

  def show
    fresh_when @city, last_modified: @city.updated_at
  end

  def create
    @city = City.create(city_params)
    respond_with @city
  end

  def update
    @city.update(city_params)
    respond_with @city
  end

  def destroy
    @city.destroy
    respond_with @city
  end


  private
    def set_city
      @city = City.friendly.find(params[:id])
    end

    def city_params
      CityParameters.new(params).permit(user: current_user)
    end
end
