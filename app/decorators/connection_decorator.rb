class ConnectionDecorator < BaseDecorator

  def from_city
    model.from_city_name
  end

  def to_city
    model.to_city_name
  end


  def distance
    @view_context.number_to_human(model.distance, units: :distance)
  end


  def percentage
    @view_context.number_to_percentage(model.percentage, precision: 0)
  end

  def cost
    @view_context.number_to_currency(model.cost, unit: 'R')
  end


  def arrive_time
    format_time(model.arrive) if model.arrive?
  end

  def depart_time
   format_time(model.depart) if model.depart?
  end

  private
   def format_time(time)
     time.strftime("%H:%M%p")
   end


end