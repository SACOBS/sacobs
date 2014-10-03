# == Schema Information
#
# Table name: notes
#
#  id      :integer          not null, primary key
#  content :text
#  context :string(255)
#  user_id :integer
#

class Note < ActiveRecord::Base
end
