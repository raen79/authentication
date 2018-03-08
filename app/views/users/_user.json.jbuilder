json.extract! user, :id, :student_id, :lecturer_id, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
