class CitiesController < ApplicationController

  params_for :city, :name, venues_attributes: [:id, :name, :_destroy]

  def index
    @cities = City.all
    respond_with @cities
  end

  def new
    @city = build_city
  end

  def create
    @city = build_city
    @city.save
    respond_with(@city, location: cities_url)
  end

  def edit
    @city = find_city(params[:id])
  end

  def update
    @city = find_city(params[:id])
    @city.update(city_params)
    respond_with(@city, location: cities_url)
  end

  def destroy
    @city = find_city(params[:id])
    @city.destroy
    respond_with(@city)
  end


  private
  def build_city
    City.new(city_params)
  end

  def find_city(id)
    City.find(id)
  end
end
