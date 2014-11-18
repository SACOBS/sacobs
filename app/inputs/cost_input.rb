class CostInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'input-prepend') do
      template.content_tag(:span, 'R', class: 'add-on') +
        @builder.text_field(attribute_name, input_html_options)
    end
  end
end
