module ParamsFor
  extend ActiveSupport::Concern

  module ClassMethods
    def params_for(model, *attributes)
      return if method_defined? "#{model}_params"
      define_method "#{model}_params" do
        params.require(model).permit(attributes).merge(user ||= {}) if params[model]
      end
      private "#{model}_params"
    end
  end
end