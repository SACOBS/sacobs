module Service
  extend ActiveSupport::Concern

  included do
    def self.execute(*args)
      new(*args).execute
    end
  end
end
