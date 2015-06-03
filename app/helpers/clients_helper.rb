module ClientsHelper
  def contact_numbers_for(client)
    [number_to_phone(client.cell_no, area_code: true), number_to_phone(client.work_no, area_code: true), number_to_phone(client.home_no, area_code: true)].compact.reject(&:blank?).join(', ')
  end

  def contact_number(number, type)
    initial = type.chr
    capture do
      concat content_tag(:abbr, "#{initial}: ", class: 'initialism', title: type)
      concat content_tag(:strong, number_to_phone(number, area_code: true))
    end
  end
end
