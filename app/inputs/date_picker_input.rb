class DatePickerInput < SimpleForm::Inputs::Base
  def input
    value = input_html_options[:value]
    value ||= object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= value.to_date.strftime('%d/%m/%Y') if value.present?
    input_html_options[:data] =  { format: 'dd/MM/yyyy' }
    template.content_tag(:div, class: 'input-append datepicker') do
      @builder.text_field(attribute_name, input_html_options) +
        template.content_tag(:span, class: 'add-on') do
          template.content_tag(:i, nil, data: { date_icon: 'icon-calendar', data_time_icon: 'icon-time' })
        end
    end
  end
end
