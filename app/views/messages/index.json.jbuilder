json.messages @messages do |msg|
  json.id         msg.id
  json.body       msg.body
  json.created_at msg.created_at

  json.user do
    json.id       msg.user.id
    json.username msg.user.username
  end
end
