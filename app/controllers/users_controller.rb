# @tag Users
# API for searching through users.
class UsersController < ApplicationController
  before_action :set_user, :only => [:show]

  # Returns a user based on query string params
  # @query_parameter [string] jwt
  # @query_parameter [string] lecturer_id
  # @query_parameter [string] student_id
  # @query_parameter [string] email
  # @response_status 200
  # @response_class UserResponse
  # There is no need to enter more than one query parameter, only the first will be used and the rest ignored
  def index
    [:id, :lecturer_id, :student_id, :email, :jwt].each do |param|
      unless search_params[param].blank?
        if param == :jwt
          @user = User.find_by_jwt(search_params[:jwt])
        elsif param == :id
          @user = User.find(search_params[:id])
        else
          @user = User.find_by(param => search_params[param])
        end

        break
      end
    end
    
    if @user.blank?
      render :status => :not_found
    else
      render :status => :ok
    end
  end

  # Returns a user based on their id
  # @response_status 200
  # @response_class UserResponse
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue
        head :not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.permit(:jwt, :lecturer_id, :student_id, :email)
    end
end
