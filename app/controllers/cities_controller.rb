class CitiesController < ApplicationController
  responders :collection, :flash

  before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @cities = city_scope.page(params[:page])
  end

  def search
    @cities = city_scope.search(params[:q]).result(distinct: true).page(params[:page])
    render partial: 'cities', locals: { cities: @cities }
  end

  def new
    @city = City.new
  end

  def show
    fresh_when @city, last_modified: @city.updated_at
  end

  def create
    @city.user = current_user
    @city = City.create(city_params)
    respond_with @city
  end

  def update
    @city.user = current_user
    @city.update(city_params)
    respond_with @city
  end

  def destroy
    @city.destroy
    respond_with @city
  end

  private

  def city_scope
    @city_scope ||= City.all
  end

  def set_city
    @city = City.includes(:venues).find(params[:id])
  end

  def city_params
    params.fetch(:city, {}).permit(:name,
                                   venues_attributes: [:id, :name, :_destroy]
                                  )
  end
end
