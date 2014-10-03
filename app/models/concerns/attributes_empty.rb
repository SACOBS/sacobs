module AttributesEmpty
  extend ActiveSupport::Concern

  IGNORED =  %w(id created_at updated_at)

  def empty?
    attributes.except(*IGNORED).values.compact.empty?
  end
end
