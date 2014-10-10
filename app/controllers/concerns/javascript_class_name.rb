module JavascriptClassName
  extend ActiveSupport::Concern

  included do
    helper_method :js_class_name
  end

  def js_class_name
    action = case action_name
               when 'create' then
                 'New'
               when 'update' then
                 'Edit'
               else
                 action_name
             end.camelize
    "Views.#{self.class.name.gsub('::', '.').gsub(/Controller$/, '')}.#{action}View"
  end
end