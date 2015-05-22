# == Schema Information
#
# Table name: scriptures
#
#  id         :integer          not null, primary key
#  verse      :character varyin
#  created_at :timestamp withou
#  updated_at :timestamp withou
#

class Bible::Scripture < ActiveRecord::Base
end
