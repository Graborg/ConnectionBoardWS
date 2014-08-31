json.array!(@api_tokens) do |api_token|
  json.extract! api_token, :access_token, :account_id
  json.url api_token_url(api_token, format: :json)
end
