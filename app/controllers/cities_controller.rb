class CitiesController < ApplicationController
  responders :collection, :flash

  before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @cities = city_scope.page(params[:page]).select(:id, :name, :venues_count, :updated_at)
  end

  def search
    @cities = city_scope.search(params[:q]).result(distinct: true).page(params[:page])
    respond_with(@cities)
  end

  def new
    @city = City.new
    @city.time_tables.build(direction: :outgoing)
    @city.time_tables.build(direction: :incoming)
  end

  def edit
    if @city.time_tables.empty?
      @city.time_tables.build(direction: :outgoing)
      @city.time_tables.build(direction: :incoming)
    end
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

  def city_scope
    @city_scope ||= City.all
  end

  def set_city
    @city = City.includes(:venues).find(params[:id])
  end

  def city_params
    params.fetch(:city, {}).permit(:name, venues_attributes: [:id, :name, :_destroy], time_tables_attributes: [:arrive, :depart, :direction]).merge(user_id: current_user.id)
  end
end
