class AuthenticationController < ApplicationController
  def login
  end

  def register
  end

  def refresh
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :lecturer_id, :student_id, :password, :password_confirmation)
    end

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
