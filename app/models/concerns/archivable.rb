module Archivable
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where(archived: true) }
    scope :available, -> { where(archived: false) }
  end

  def archive!
    self.archived = true
    self.archived_at = Time.current
    save!(validate: false)
  end
end
