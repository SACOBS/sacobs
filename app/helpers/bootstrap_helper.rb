module BootstrapHelper
  TABLE_CLASSES = { default: 'table', bordered: 'table-bordered', striped: 'table-striped', hover: 'table-hover', condensed: 'table-condensed' }

  def bootstrap_table(*args)
    options = args.extract_options!
    html_options = options.fetch(:html_options) { Hash.new }
    html_options[:class] ||= []
    html_options[:class] = table_classes(options[:types])  <<  html_options[:class].split
    haml_tag :table, html_options do
      table_headers(options[:headers])
      haml_tag :tbody, class: 'page' do
        yield if block_given?
      end
    end
  end

  def table_classes(classes)
    (classes.map { |item| TABLE_CLASSES[item] }).compact.push(TABLE_CLASSES[:default])
  end

  def table_headers(headers)
    if headers && headers.any?
      haml_tag :thead do
          haml_tag :tr do
            headers.each { |h| haml_tag :th, h }
          end
      end
    end

  end

  def drop_down_menu(name)
    haml_tag :li, class: 'dropdown' do
      haml_tag :a, class: 'dropdown-toggle', href: '#', data: { toggle: 'dropdown' } do
        haml_concat name
        haml_tag :b, class: 'caret'
      end
      haml_tag :ul, class: 'dropdown-menu' do
        yield if block_given?
      end
    end
  end
end
