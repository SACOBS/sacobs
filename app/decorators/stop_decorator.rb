class StopDecorator < Draper::Decorator
  delegate_all

  decorates_association :connection


  def from_city
    connection.from_city
  end

  def to_city
    connection.to_city
  end

  def from
    connection.from
  end

  def to
    connection.to
  end

  def arrive
    model.arrive.strftime("%H:%M%p")
  end

  def depart
    model.depart.strftime("%H:%M%p")
  end


end