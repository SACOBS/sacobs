class UsersController < ApplicationController
  before_action :set_user, only: :update

  def index
    @users = User.all_except(current_user).select(:name, :email, :surname, :role, :id, :updated_at)
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
    { resource_name: @user }
  end
end
