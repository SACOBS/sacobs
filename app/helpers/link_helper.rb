module LinkHelper

  def link_to(text, path, options = {}, &block)
    icon = iconize options.delete(:icon)
    text = content_tag(:i, " #{text}", class: icon) if icon
    super
  end

  def iconize(name)
    "fa fa-#{name.to_s.gsub('_','-')}"
  end

end