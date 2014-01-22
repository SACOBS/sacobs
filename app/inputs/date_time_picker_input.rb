class DateTimePickerInput < SimpleForm::Inputs::Base
  def input
    value = input_html_options[:value]
    value ||= object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= Time.zone.at(value).strftime("%d/%m/%Y %H:%M:%S %p")  if value.present?
    input_html_options[:data] =  {format: "dd/MM/yyyy hh:mm:ss PP"}
    template.content_tag(:div, class: 'input-append datetimepicker') do
      @builder.text_field(attribute_name, input_html_options) +
      template.content_tag(:span, class: "add-on") do
        template.content_tag(:i, nil, data: {date_icon: 'icon-calendar', data_time_icon: 'icon-time'})
      end
    end
  end
end