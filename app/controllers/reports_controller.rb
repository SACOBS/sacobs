class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.create(report_params)
    respond_with @report, location: reports_url
  end

  def search
    @results = Booking.search(params[:q]).result.distinct(true).group_by { |r| r.created_at.beginning_of_month }
    render :index
  end

  def cities
    @cities ||= City.all.to_json(only: [:id, :name])
  end
  helper_method :cities

  private

  def report_params
    params.fetch(:report, {}).permit(:name, criteria: [:stop_connection_from_city_id_eq, :stop_connection_to_city_id_eq, status_eq_any: [], passengers_passenger_type_id_eq_any: []])
  end
end
