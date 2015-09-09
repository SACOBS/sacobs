class CreateConnections
  delegate :connections, :destinations, to: :route

  def initialize(route)
    @route = route
  end

  def perform
    Route.transaction do
      destinations.each do |from|
        destinations.drop(from.sequence).each { |to| connections.find_or_create_by(from_id: from.id, to_id: to.id, cost: nil) }
      end
    end
    connections.all?(&:persisted?)
  end

  private
  attr_reader :route
end
