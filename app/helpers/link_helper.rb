module LinkHelper

  def link_to(text, path, options = {}, &block)
    icon = iconize options.delete(:icon)
    text = content_tag(:i, " #{text}", class: icon) if icon
    super
  end

  def iconize(name)
    "fa fa-#{name.to_s.gsub('_','-')}"
  end

  def back_to(path)
   link_to 'Back', path, class: 'btn btn-primary', icon: :arrow_left
  end
end