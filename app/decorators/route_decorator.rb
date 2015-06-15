class RouteDecorator < LittleDecorator
  def name
    record.name.upcase
  end

  def connections_count
    connections.size
  end

  def start_city
    destinations.first.name
  end

  def end_city
    destinations.last.name
  end

  def cost
    number_to_currency(record.cost)
  end

  def distance
    number_to_human(record.distance, units: :distance)
  end

  def add_destination_link(opts = {})
    opts.merge!(icon: :plus)
    link_to 'Add Destination', edit_route_destinations_path(record), opts
  end

  def copy_link(opts = {})
    opts.merge!(method: :post, icon: :copy)
    link_to 'Copy', copy_route_path(record), opts
  end

  def destroy_link(opts = {})
    return if connections.any?
    opts.merge!(method: :delete, icon: :times)
    link_to 'Destroy', record, opts
  end

  def edit_link(opts = {})
    opts.merge!(icon: :edit)
    link_to 'Edit', edit_route_path(record), opts
  end

  def reverse_copy_link(opts = {})
    opts.merge!(method: :post, icon: :copy)
    link_to 'Reverse Copy', reverse_copy_route_path(record), opts
  end

  def show_link(opts = {})
    opts.merge!(icon: :info)
    link_to 'Show', record, opts
  end
end
