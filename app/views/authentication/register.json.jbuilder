if @jwt.blank?
  json.errors @user.errors
else
  json.extract! @user, :id, :email, :lecturer_id, :student_id
  json.jwt @jwt
end