json.extract! message, :id, :body, :from, :to, :created_at, :updated_at
json.url message_url(message, format: :json)
