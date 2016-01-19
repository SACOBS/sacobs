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
    random_scripture = find_by(id: rand(count))
    begin
      Scripture.get_verse(random_scripture.verse)
    rescue
      nil
    end
  end
end
