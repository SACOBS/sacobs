class Route::Create
  attr_reader :route

  delegate :connections, :destinations, to: :route

  def self.perform(*args)
    new(*args).perform
  end

  def initialize(params)
    @route = Route.new
    @route.assign_attributes(params)
  end

  def perform
    Route.transaction { raise ActiveRecord::Rollback unless route.save && create_connections }
    route
  end

  private

  def create_connections
    destinations.sort_by(&:sequence).each do |from|
      destinations.sort_by(&:sequence).drop(from.sequence).each { |to| connections.find_or_create_by(from_id: from.id, to_id: to.id) }
    end
    connections.all?(&:persisted?)
  end

end