class StopDecorator < Draper::Decorator
  delegate_all

  decorates_association :connection

  def from
    connection.from
  end

  def to
    connection.to
  end

  def arrive
    l model.arrive, format: :dateless
  end

  def depart
    l model.depart, format: :dateless
  end


end