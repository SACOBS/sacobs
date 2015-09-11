class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @cities = City.all.page(params[:page])
    respond_with(@cities) if stale?(@cities)
  end

  def search
    @cities = City.search(params[:q]).result(distinct: true).page(params[:page])
    respond_with(@cities)
  end

  def new
    @city = City.new
  end

  def show
    fresh_when @city
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
    @city = City.find(params[:id])
  end

  def city_params
    params.fetch(:city, {}).permit(:name, venues_attributes: [:id, :name, :_destroy]).merge(user_id: current_user.id)
  end
end
