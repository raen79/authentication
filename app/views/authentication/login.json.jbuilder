if @jwt.nil?
  json.error 'email was not found or password incorrect'
else
  json.jwt @jwt
end