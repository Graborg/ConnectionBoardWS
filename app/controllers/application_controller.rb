class ApplicationController < ActionController::Base
  class_attribute :account_id
  class_attribute :object_id
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session



private

    def restrict_access (type)
	  	authenticate_or_request_with_http_token do |token, options|
	  		@token_account_id = ApiToken.where(access_token: token) 
	  		if (type == 'project')
	  			@param_account_id = Project.where(:id => @object_id)[0][:account_id]
	  		elsif (type == 'person')
	  			@param_account_id = Person.where(:id  => @object_id)[0][:account_id]
	  		else
	  			@param_account_id = Account.where(:id  => @object_id)[0][:id]
	  		end
	  		head :unauthorized unless @token_account_id[0] != nil and @token_account_id[0][:account_id]  == @param_account_id
	 		true
	 	end
	end
	def restrict_create
		authenticate_or_request_with_http_token do |token, options|
			@token_account_id = ApiToken.where(access_token: token)
			puts "ACCOUNT ID"
			puts @token_account_id[0][:account_id]
			if @token_account_id[0] != nil 
	  			@account_id = @token_account_id[0][:account_id]
	  		end
	  	end
	end

end