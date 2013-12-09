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
       defaults.each { |key, value| write_attribute(key, value) unless read_attribute(key) }
    end
end