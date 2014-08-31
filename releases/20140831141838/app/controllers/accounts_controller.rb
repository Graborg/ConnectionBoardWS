 require 'bcrypt'

class AccountsController < ApplicationController
	before_filter :restrict_access, :only => [:update, :show]
	
	def login
		if @account = Account.find_by_username(params[:username]).try(:authenticate, params[:password])
			@api_key = ApiToken.find_by_account_id(@account.id)[:access_token]
			@response = Hash.new()
			@response[:token] = @api_key 
			@response[:account_id] = @account.id.to_s
			render :json => @response
		else
			head :unauthorized
		end
	end


	def new
		@account = Account.new()
	end

	def create
	  	@account = Account.new(params.permit([:username]))
	  	@account.password = params[:password]
	  	@account.password_confirmation = params[:password]
	  	@account.save!
	  	@api_key = @account.create_api_token
		Mailer.welcome_email(@account).deliver
		@response = Hash.new()
		@response[:token] = @api_key[:access_token] 
		@response[:account_id] = @account[:id].to_s
		render :json => @response
	end

	def edit
	  	@account = Accounts.find(params[:id])
	end


	def index
		result = Hash.new()
		result['accounts'] = Account.joins(:api_token).select("access_token, account_id").all
 		@accounts = render :json => result
	end


	def show
  		@account = render :json => Account.find(params[:id])
	end
	
	def update
		@account = Account.find(params[:id])
		if @account.update(params.permit(:username, :password))
			render :json => @account
		else
			render 'edit'
		end
	end

	def restrict_access
		@object_id = params[:id]
		super('account')
	end
end