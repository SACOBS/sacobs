class CitiesController < ApplicationController
  before_action :set_city, only: [:edit, :update, :destroy]

  params_for :city, :name, venues_attributes: [:id, :name, :_destroy]

  def index
    @cities = City.all
    respond_with @cities
  end

  def new
    @city = City.new
  end

  def create
    @city = City.create(city_params)
    respond_with(@city, location: cities_url)
  end

  def update
    @city.update(city_params)
    respond_with(@city, location: cities_url)
  end

  def destroy
    @city.destroy
    respond_with(@city)
  end


  private
  def set_city
    @city = City.find(params[:id])
  end

end
