class RouteDecorator < Draper::Decorator
  delegate_all

  decorates_association :connections

  def cost
    h.number_to_currency(model.cost, unit: 'R')
  end

  def distance
    h.number_to_human(route.distance, units: :distance)
  end

  def edit_link
    h.link_to 'Edit', edit_path, icon: :edit, class: 'btn btn-info'
  end

  def destroy_link
    h.link_to 'Destroy', destroy_path , method: :delete, data: { confirm: 'Are you sure you want to delete this route?' }, icon: :times, class: 'btn btn-danger'
  end

  private
    def edit_path
      h.route_builder_path(:details, route_id: model)
    end

    def destroy_path
      h.route_path(model)
    end

end
