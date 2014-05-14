class TripSearch
  include Service

  def initialize(criteria)
    @criteria = criteria.reject{|k, v| v =~ /Select/ }
  end

  def execute
   Stop.search(@criteria).result(distinct: true).valid.limit(30)
  end
end