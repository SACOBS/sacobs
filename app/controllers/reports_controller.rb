class ReportsController < ApplicationController
  before_action :set_report, except: [:index, :new, :create]
  before_action :set_results, except: [:index, :new, :create]

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
  end

  def download
    render_pdf(disposition: :attachment)
  end

  def print
    render_pdf
  end

  def destroy
    @report.destroy
    respond_with @report
  end

  private

  def render_pdf(disposition: :inline)
    render pdf: @report.to_file_name, template: 'reports/_results.html.haml', disposition: disposition, layout: 'pdf.html'
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def set_results
    @results = Booking.unscoped { Booking.all }.processed.includes(invoice: :line_items).where(created_at: @report.period_from..@report.period_to).search(@report.criteria).result
  end

  def report_params
    params.fetch(:report, {}).permit(:name, :period_from, :period_to, criteria: [:stop_connection_from_city_id_eq, :stop_connection_to_city_id_eq, status_eq_any: [], passengers_passenger_type_id_eq_any: []])
  end
end
