class SettingParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:setting).permit(setting_attributes).merge(additional_attr)
  end

  private
    def setting_attributes
      [ :booking_expiry_period, :ticket_instructions, :default_scripture ]
    end
end