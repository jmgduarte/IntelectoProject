json.extract! user, :id, :fullNames, :lastNames, :email
json.url api_v1_user_url(user, format: :json)

