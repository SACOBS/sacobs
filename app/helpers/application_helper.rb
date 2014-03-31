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
      content_tag(:div, class: 'error_explanation well well small') do
        concat (content_tag(:div, "#{pluralize(model.errors.count, 'error')} prevented this record from being saved:", class: 'alert alert-error' ))
        concat ( content_tag(:ul) { model.errors.full_messages.map do |msg|
          content_tag(:li, msg)
        end.join().html_safe
        })
      end
    end
  end

  def clients
    @clients ||= Client.select(:id,:full_name,:high_risk)
  end

  def cities
    @cities ||= City.select(:id, :name)
  end

  def titles
    @titles ||= Title.select(:name)
  end

  def route_cities(route)
    @route_cities ||= route.destinations.map(&:city)
  end

  def ticket_scripture
   ScriptureService.new.fetch || settings.default_scripture
  end

  def invoice_total(booking)
    total = booking.invoice.total
    return_total = booking.return.invoice.total if booking.return
    total += (return_total || 0)
  end
end
