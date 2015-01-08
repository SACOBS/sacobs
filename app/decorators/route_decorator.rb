class RouteDecorator < BaseDecorator
  def start_city
    return 'None' unless destinations.any?
    destinations.first.city_name
  end

  def end_city
    return 'None' unless destinations.any?
    destinations.last.city_name
  end

  def cost
    @view_context.number_to_currency(model.cost, unit: 'R')
  end

  def connections_count
    model.connections.size
  end

  def distance
    @view_context.number_to_human(model.distance, units: :distance)
  end

  def add_destination_link(options = {})
    options.merge!(data: { toggle: 'tooltip', title: 'Click here to add a new destination (eg East London) to the route.' }, rel: 'tooltip')
    helpers.link_to 'Add Destination', helpers.edit_route_destinations_path(model), options
  end

  def copy_link(options = {})
    options.merge!(method: :post, data: { toggle: 'tooltip', title: 'Click here to create a copy of this route.' }, rel: 'tooltip')
    helpers.link_to 'Copy', helpers.copy_route_path(model), options
  end

  def reverse_copy_link(options = {})
    options.merge!(method: :post, data: { toggle: 'tooltip', title: 'Click here to create a copy of this route in reverse(eg EL to PE will be copied as PE to EL).' }, rel: 'tooltip')
    helpers.link_to 'Reverse Copy', helpers.reverse_copy_route_path(model), options
  end

  def show_link(options = {})
    helpers.link_to 'Show', model, options
  end

  def edit_link(options = {})
    helpers.link_to 'Edit', helpers.edit_route_path(model), options
  end

  def destroy_link(options = {})
    options.merge!(method: :delete, data: { confirm: helpers.t('messages.confirm', resource: :route) })
    helpers.link_to_unless(model.connections.any?, 'Destroy', model, options) {}
  end
end
