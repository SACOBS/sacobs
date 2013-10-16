module AttributesEmpty
  extend ActiveSupport::Concern

  included do
    IGNORED =  %w(id created_at updated_at)
  end

  def empty?
    self.attributes.except(*IGNORED).values.compact.empty?
  end
end