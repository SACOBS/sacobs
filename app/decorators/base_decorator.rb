require 'delegate'

class BaseDecorator < SimpleDelegator

  def initialize(obj, view_context=nil)
    __setobj__(obj)
    @view_context = view_context
  end

  def self.decorate(obj, view_context=nil)
    new(obj, view_context)
  end


  def model
    __getobj__
  end

  private
   def helpers
     @view_context
   end
end