if @user.blank?
  json.error 'could not find the user with the parameters provided'
else
  json.partial! 'users/user', user: @user
end