module Archivable
  extend ActiveSupport::Concern

  included do
    default_scope { where(archived: false) }

    scope :archived, -> { unscoped { where(archived: true) } }
  end

  def archive!
    self.archived = true
    self.archived_at = Time.current
    save!(validate: false)
  end
end