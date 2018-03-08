# @tag Faqs
# API for authenticating users.
class AuthenticationController < ApplicationController
  # Returns a jwt token with expiration of 4 hours
  # @body_parameter [Login] login
  # @response_status 200
  # @response_class JwtResponse
  def login
    @jwt = User.login(:email => login_params[:email], :password => login_params[:password])
    render :status => :not_found if @jwt.nil?
  end

  # Creates a new user (lecturer or student)
  # @body_parameter [User] user
  # @response_status 201
  # @response_class UserRegisteredResponse
  def register
    @user = User.new(user_params)

    if @user.save
      @jwt = User.login(:email => @user.email, :password => @user.password)
      render :status => :created
    else
      render :status => :unprocessable_entity
    end
  end

  # Refreshes non-expired tokens
  # @body_parameter [JwtParams] jwt
  # @response_status 200
  # @response_class JwtResponse
  def verify_token
    @jwt = User.refresh_jwt(jwt_params[:token])
    if @jwt.blank?
      render :status => :unprocessable_entity
    else
      render :status => :ok
    end
  end

  private
    def jwt_params
      params.require(:jwt).permit(:token)
    end

    def user_params
      params.require(:user).permit(:id, :email, :lecturer_id, :student_id, :password, :password_confirmation)
    end

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
