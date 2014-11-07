class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session

	@@admins = {"IOS" => "jacobarvidsson@me.com", "WP" => "jonathan.v@live.se",
		"Android" => "oscar.axelsson14@gmail.com", "Web" => "mgraborg@gmail.com"}

	def index
	end

	private

	def restrict_access
		authenticate_or_request_with_http_token do |token, options|
			api_token = ApiToken.find_by_access_token(token)
			param_account = self.get_account
			api_token && api_token.account_id == param_account.id
		end
	end

	def restrict_create
		authenticate_or_request_with_http_token do |token, options|
			api_token = ApiToken.find_by_access_token(token)
			@token_account = api_token.account if api_token
		end
	end

	def error(status, code, message)
		render :json => {:response_type => "ERROR", :response_code => code, :message => message}.to_json, :status => status
	end

end