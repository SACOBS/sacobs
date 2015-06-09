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
  default_scope { order(id: :desc) }

  scope :for_context, ->(context) { where(context: context) }
end
