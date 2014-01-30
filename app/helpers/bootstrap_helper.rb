module BootstrapHelper

  TABLE_CLASSES = { default: 'table', bordered: 'table-bordered', striped: 'table-striped', hover: 'table-hover', condensed: 'table-condensed' }


  def glyph(*names)
    content_tag :i, nil, class: names.map{|name| "icon-#{name.to_s.gsub('_','-')}" }
  end

  def nav_list(html_options = {})
    html_options.merge!(class: 'nav nav-list')
    haml_tag :ul, html_options do
      haml_tag :li, 'Menu' ,class: 'nav-header'
      yield if block_given?
    end
  end


  def bootstrap_table(*args)
    options = args.extract_options!
    html_options = options.fetch(:html_options) { Hash.new }
    html_options[:class] ||= []
    html_options[:class] = table_classes(options[:types])  <<  html_options[:class].split
    haml_tag :table, html_options do
      table_headers(options[:headers])
      haml_tag :tbody do
        yield if block_given?
      end
    end
  end

  def table_classes(classes)
    (classes.map { |item| TABLE_CLASSES[item] }).compact.push(TABLE_CLASSES[:default])
  end

  def table_headers(headers)
    haml_tag :thead do
      haml_tag :tr do
        headers.each { |h| haml_tag :th, h }
      end
    end
  end

  def popover(help_key)
     simple_format(I18n.t help_key, scope: [:help])
  end

  def carousel(carousel_id)
    haml_tag :div, id: carousel_id, class:'carousel slide' do
      haml_tag :div, class: 'carousel-inner' do
        yield if block_given?
      end
      haml_tag :a, class: 'left carousel-control', data: {  href: carousel_id, slide: 'prev'} do
        concat('‹').html_safe
      end
      haml_tag :a, class: 'right carousel-control', data: { href: carousel_id, slide: 'next' } do
        concat('›').html_safe
      end
    end
  end

  def carousel_item(*args)
    options = args.extract_options!
    haml_tag :div, class: "item #{'active' if options[:active]}" do
      concat(image_tag(options[:image])).html_safe
      yield if block_given?
    end
  end

  def carousel_caption(*args)
    options = args.extract_options!
    haml_tag :div, class: 'carousel-caption' do
      if options[:label]
        haml_tag :h4 do
          concat(options[:label])
        end
      end
      if options[:caption]
        haml_tag :p do
          concat(options[:caption])
        end
      end
    end
  end

  def drop_down_menu(name)
    haml_tag :li, class: 'dropdown' do
      haml_tag :a ,class: 'dropdown-toggle', href: '#', data: {toggle: 'dropdown'} do
        haml_concat name
        haml_tag :b ,class: 'caret'
      end
      haml_tag :ul, class: 'dropdown-menu' do
        yield if block_given?
      end
    end
  end

end