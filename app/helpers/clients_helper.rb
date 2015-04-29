module ClientsHelper
  def contact_numbers_for(client)
    [number_to_phone(client.cell_no, area_code: true), number_to_phone(client.work_no, area_code: true), number_to_phone(client.home_no, area_code: true)].compact.reject(&:empty?).join(', ')
  end
end
