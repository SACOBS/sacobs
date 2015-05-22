module ApplicationHelper
  def title(title)
    content_for(:title, title)
  end

  def description(description)
    content_for(:description, description)
  end

  def keywords(keywords)
    content_for(:keywords, keywords)
  end

  def errors_for(model)
    if model && model.errors.any?
      content_tag(:div, class: 'error_explanation well well-small') do
        concat (content_tag(:div, "#{pluralize(model.errors.count, 'error')} prevented this record from being saved:", class: 'alert alert-error'))
        concat (content_tag :ul do
          model.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
        end)
      end
    end
  end

  def route_cities(route)
    @route_cities ||= route.destinations.map(&:city)
  end

  def current_trips_count
    @current_trips_count ||= Trip.count
  end

  def invoice_total(booking)
    [booking, booking.return_booking].compact.map { |b| b.invoice.total }.sum
  end
end
