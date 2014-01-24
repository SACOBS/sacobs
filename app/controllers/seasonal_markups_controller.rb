class SeasonalMarkupsController < ApplicationController
  responders :collection, :flash

  def index
    @seasonal_markups = SeasonalMarkup.all.decorate
  end

  def new
    @seasonal_markup = SeasonalMarkup.new
  end

  def create
   @seasonal_markup = SeasonalMarkup.create(seasonal_markup_params)
   respond_with @seasonal_markup
  end

  def update
    @seasonal_markup = SeasonalMarkup.find(params[:id])
    @seasonal_markup.update(seasonal_markup_params)
    respond_with @seasonal_markup
  end


  private
   def seasonal_markup_params
     SeasonalMarkupParameters.new(params).permit(user: current_user)
   end
end