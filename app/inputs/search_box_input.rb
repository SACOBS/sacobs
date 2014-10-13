class SearchBoxInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:placeholder] = 'Search'
    input_html_classes.push 'search-query'
    @builder.text_field(attribute_name, input_html_options)
  end
end
