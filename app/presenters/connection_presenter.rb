class ConnectionPresenter



  attr_reader :connection
  def initialize(connection, view_context)
    @connection = connection
    @view_context = view_context
  end

  def from_city
    connection.from_city_name
  end

  def to_city
    connection.to_city_name
  end


  def distance
    @view_context.number_to_human(connection.distance, units: :distance)
  end


  def percentage
    @view_context.number_to_percentage(connection.percentage, precision: 0)
  end

  def cost
    @view_context.number_to_currency(connection.cost, unit: 'R')
  end


  def arrive_time
    connection.arrive.strftime("%H:%M%p") if connection.arrive?
  end

  def depart_time
    connection.depart.strftime("%H:%M%p") if connection.depart?
  end


end