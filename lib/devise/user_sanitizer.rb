class UserSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:name,:surname, :email, :password, :password_confirmation)
  end

  def account_update
    default_params.permit(:name,:surname, :email, :password, :password_confirmation, :current_password)
  end
end

