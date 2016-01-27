module FlashHelper
  def alert_class_for(type)
    { notice: 'alert-success', alert: 'alert-danger' }[type.to_sym]
  end
end
