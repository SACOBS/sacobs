class SettingParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:setting).permit(setting_attributes).merge(additional_attr)
  end

  private

  def setting_attributes
    [:booking_expiry_period, :ticket_instructions, :default_scripture, :trip_sheet_note1, :trip_sheet_note2, :trip_sheet_note3, :trip_sheet_note4]
  end
end
