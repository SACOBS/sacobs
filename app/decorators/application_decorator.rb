class ApplicationDecorator

  def h
    Helpers
  end

  def router
    Rails.application.routes.url_helpers
  end

  def link_to(text, path, options = {}, &block)
    icon = font_awesome(options.delete(:icon))
    text = h.content_tag(:i, " #{text}", class: icon) if icon
    h.link_to(text, path, options, &block)
  end

  private
  def font_awesome(name)
    "fa fa-#{name.to_s.gsub('_','-')}"
  end

  module Helpers
    extend ActionView::Helpers::NumberHelper
    extend ActionView::Helpers::UrlHelper
    extend ActionView::Helpers::TagHelper
  end
end