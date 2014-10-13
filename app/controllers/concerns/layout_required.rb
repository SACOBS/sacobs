module LayoutRequired
  extend ActiveSupport::Concern

  included do
    layout :layout_required?
  end

  private

  def layout_required?
    false if request.xhr?
  end
end
