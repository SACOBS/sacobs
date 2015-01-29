class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def create

  end

  def search
    @results = Booking.search(params[:q]).result.distinct(true).group_by { |r| r.created_at.beginning_of_month }
    render :index
  end

  def cities
    @cities ||= City.all.to_json(only: [:id, :name])
  end
  helper_method :cities
end
