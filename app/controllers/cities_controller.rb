class CitiesController < ApplicationController
  def index
    @cities = City.pluck(:name)
    respond_with @cities
  end
end
