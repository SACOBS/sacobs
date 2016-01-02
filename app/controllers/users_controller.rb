# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  surname                :string(255)
#  role                   :integer          default(0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class UsersController < ApplicationController
  before_action :set_user, only: :update

  def index
    @users = User.where.not(id: current_user.id)
    respond_with(@users) if stale?(@users)
  end

  def update
    @user.update(params.require(:user).permit(:role))
    respond_with @user, location: users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def interpolation_options
    { resource_name: @user.full_name }
  end
end
