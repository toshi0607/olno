json.array!(@statuses) do |status|
  json.extract! status, :id, :user_id, :logged_in_at, :logged_out_at
  json.url status_url(status, format: :json)
end
