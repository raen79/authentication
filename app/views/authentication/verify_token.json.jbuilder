if @jwt.blank?
  json.error 'User could not be found or JWT expired'
else
  json.jwt @jwt
end