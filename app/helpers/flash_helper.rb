module FlashHelper
  def alert_class_for(type)
    { notice: 'alert alert-success', error: 'alert alert-error' }[type.to_sym]
  end
end
