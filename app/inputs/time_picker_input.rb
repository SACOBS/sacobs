class TimePickerInput < SimpleForm::Inputs::Base
  def input
    value = input_html_options[:value]
    value ||= object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= Time.at(value).strftime('%H:%M%p')  if value.present?
    input_html_options[:data] =  { format: 'hh:mm PP' }
    template.content_tag(:div, class: 'input-append timepicker') do
      @builder.text_field(attribute_name, input_html_options) +
          template.content_tag(:span, class: 'add-on') do
            template.content_tag(:i, nil, data: { time_icon: 'icon-time', date_icon: 'icon-calendar' })
          end
    end
  end
end
