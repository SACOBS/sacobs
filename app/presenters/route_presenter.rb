class RoutePresenter

  delegate :name, :connections_count, to: :route

  attr_reader :route

  def initialize(route, view_context)
    @route = route
    @view_context = view_context
  end

  def start_city
    route.destinations.first.city_name
  end

  def end_city
    route.destinations.last.city_name
  end

  def cost
    @view_context.number_to_currency(route.cost, unit: 'R')
  end

  def distance
    @view_context.number_to_human(route.distance, units: :distance)
  end

end