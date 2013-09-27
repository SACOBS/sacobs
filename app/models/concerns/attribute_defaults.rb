module AttributeDefaults
  extend ActiveSupport::Concern

  included do
    after_initialize :set_default_attributes, if: :new_record?
  end

  private
  def defaults
    {}
  end

  protected
  def set_default_attributes
     defaults.each { |key, value| write_attribute(key, value) if read_attribute(key).nil? }
  end
end