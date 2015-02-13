class ReportsController < ApplicationController
  before_action :set_report, except: [:index, :new, :create]

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

  def edit
  end

  def update
    @report.update(report_params)
    respond_with @report
  end

  def show
    @results = Booking.not_in_process.search(@report.criteria).result
  end

  def destroy
    @report.destroy
    respond_with @report
  end




  def cities
    @cities ||= City.all.to_json(only: [:id, :name])
  end
  helper_method :cities

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.fetch(:report, {}).permit(:name, criteria: [:stop_connection_from_city_id_eq, :stop_connection_to_city_id_eq, status_eq_any: [], passengers_passenger_type_id_eq_any: []])
  end
end
