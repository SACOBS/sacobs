# == Schema Information
#
# Table name: scriptures
#
#  id         :integer          not null, primary key
#  verse      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bible::Scripture < ActiveRecord::Base
  def self.for_today
    Scripture.get_verse(find(rand(count)).verse) rescue nil
  end
end
