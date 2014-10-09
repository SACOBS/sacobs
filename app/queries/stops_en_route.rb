class StopsEnRoute < Struct.new(:trip, :stop)
  def stops
    @stops ||= trip.stops.joins(connection: :to).where(destinations_to_come.and(stops_to_ignore))
  end

  private

  def from_destination
    @from_destination ||= stop.connection.from
  end

  def to_destination
    @to_destination ||= stop.connection.to
  end

  def stops_to_ignore
    (connection_table[:from_id].not_eq(to_destination.id))
  end

  def destinations_to_come
    destination_table[:sequence].gt(from_destination.sequence)
  end

  def destination_table
    Destination.arel_table
  end

  def connection_table
    Connection.arel_table
  end
end
