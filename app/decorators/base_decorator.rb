require 'delegate'

class BaseDecorator < SimpleDelegator
  class << self
    alias_method :decorate, :new
  end

  def initialize(obj, view_context)
    __setobj__(obj)
    @view_context = view_context
    yield self if block_given?
  end

  def model
    __getobj__
  end

  private

  def helpers
    @view_context
  end
end
