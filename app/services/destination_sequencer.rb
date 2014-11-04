# Resequences destinations when a new destination is added
class DestinationSequencer
  def initialize(route, city, preceding)
    @route = route
    @city = city
    @preceding = preceding || NullDestination.new
  end

  def resequence
    ActiveRecord::Base.transaction do
      destinations = @route.destinations.reject { |d| d.sequence <= @preceding.sequence }
      destinations.each { |d| d.increment(:sequence) }
      destinations << @route.destinations.build(city: @city, sequence: @preceding.sequence.next)
      destinations.each(&:save!)
    end
  rescue StandardError => error
    Rails.logger.error error.inspect
  end
end
