class AuthenticationController < ApplicationController
  def login
    begin
      @jwt = User.login(:email => login_params[:email], :password => login_params[:password])
      render :status => :not_found if @jwt.nil?
    rescue ActionController::ParameterMissing => message
      render :json => { :error => message }, :status => :unprocessable_entity
    end
  end

  def register
  end

  def refresh
  end

  private
    def current_user
      @current_user ||= User.find_by_jwt(request.headers['Authorization'])
    end

    def user_params
      params.require(:user).permit(:id, :email, :lecturer_id, :student_id, :password, :password_confirmation)
    end

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
