class DistanceInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'input-group') do
      @builder.text_field(attribute_name, input_html_options) +
        template.content_tag(:span, 'Km', class: 'input-group-addon')
    end
  end
end
