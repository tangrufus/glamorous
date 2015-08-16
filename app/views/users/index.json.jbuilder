json.array! @users do |user|
  next unless user.confirmed?

  json.extract! user, :id, :email, :username
end
