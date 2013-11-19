# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

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
