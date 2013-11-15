class Setting < ActiveRecord::Base
  before_save :format_key

  def self.to_hash
    all.inject({}) { |settings, setting| settings.merge({setting[:key] => setting[:value]}) }
  end

  protected
    def format_key
      self.key = self.key.underscore
    end
end
