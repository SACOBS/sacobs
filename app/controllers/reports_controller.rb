# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  criteria    :json             default({}), not null
#  period_from :date
#  period_to   :date
#  daily       :boolean          default(FALSE)
#

class ReportsController < ApplicationController
  before_action :set_report, except: [:index, :new, :create]
  before_action :set_results, only: [:show, :download, :pdf]

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

  def show;end

  def download
    render pdf: @report.to_file_name, template: 'reports/results.pdf.erb', disposition: :attachment, layout: 'application.pdf.erb'
  end

  def print
    render pdf: @report.to_file_name, template: 'reports/results.pdf.erb', layout: 'application.pdf.erb'
  end

  def destroy
    @report.destroy
    respond_with @report
  end

  private
  def set_report
    @report = Report.find(params[:id])
  end

  def set_results
    @results = Booking.includes(:client, :invoice, :trip, stop: :connection).completed.where(created_at: @report.date_range).search(@report.criteria).result
  end

  def report_params
    params.fetch(:report, {}).permit(:name, :daily, :period_from, :period_to, criteria: [:stop_connection_from_city_id_eq, :stop_connection_to_city_id_eq, status_eq_any: [], passengers_passenger_type_id_eq_any: []])
  end
end
