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

  def link_to(text, path, options = {}, &block)
    icon = options.delete(:icon)
    text = content_tag(:i, " #{text}", class: icon) if icon
    super
  end
end
