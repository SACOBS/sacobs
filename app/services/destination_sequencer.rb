# Resequences destinations when a new destination is added
class DestinationSequencer
  def initialize(route, city, preceding)
    @route = route
    @city = city
    @preceding = preceding || NullDestination.new
  end

  def resequence
    Route.transaction do
      @route.destinations.each { |d| d.increment(:sequence) if d.sequence > @preceding.sequence }
      @route.destinations.build(city: @city, sequence: @preceding.sequence.next)
      @route.save
    end
  rescue StandardError => error
    Rails.logger.error error.inspect
  end
end
