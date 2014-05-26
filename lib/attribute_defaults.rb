module AttributeDefaults
    extend ActiveSupport::Concern

    included do
      after_initialize :set_default_attributes, prepend: true, if: :new_record?
    end

    private
      def defaults
        {}
      end

    protected
    def set_default_attributes
      defaults.each do |key, value|
        (value.respond_to? :call) ? default_value = value.call : default_value = value
        send(key) || send("#{key}=", default_value)
      end
    end
end

