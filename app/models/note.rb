# == Schema Information
#
# Table name: notes
#
#  id      :integer          not null, primary key
#  content :text
#  context :string(255)
#  user_id :integer
#
# Indexes
#
#  index_notes_on_user_id  (user_id)
#

class Note < ActiveRecord::Base
  default_scope { order(id: :desc) }
end
