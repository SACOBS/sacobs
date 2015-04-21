module BootstrapHelper
  TABLE_CLASSES = { default: 'table', bordered: 'table-bordered', striped: 'table-striped', hover: 'table-hover', condensed: 'table-condensed' }

  def bootstrap_table(*args)
    options = args.extract_options!
    html_options = options.fetch(:html_options, {})
    html_options[:class] ||= []
    html_options[:class] = table_classes(options[:types]) << html_options[:class].split
    content_tag :table, html_options do
      concat(table_headers(options[:headers]))
      concat(content_tag(:tbody, class: 'page') { yield if block_given? })
    end
  end

  def table_classes(classes)
    (classes.map { |item| TABLE_CLASSES[item] }).compact.push(TABLE_CLASSES[:default])
  end

  def table_headers(headers)
    if headers.present?
      content_tag(:thead) do
        concat(content_tag(:tr) do
          headers.each { |h| concat(content_tag(:th, h)) }
        end)
      end
    end
  end

  def drop_down_menu(name)
    content_tag(:li, class: 'dropdown') do
      concat(drop_down_toggle(name))
      concat(content_tag(:ul, class: 'dropdown-menu') { yield if block_given? })
    end
  end

  def drop_down_toggle(text)
    content_tag(:a, class: 'dropdown-toggle', href: '#', data: { toggle: 'dropdown' }) do
      concat(text)
      concat(content_tag(:b, nil, class: 'caret'))
    end
  end
end
