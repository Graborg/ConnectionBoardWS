class PasswordResetsController < ApplicationController
	def create
		account = Account.find_by_username(params[:username])
		account.send_password_reset if account
		redirect_to root_url, :notice => "Email sent with password reset instructions."
	end

	def edit
		@account = Account.find_by_password_reset_token!(params[:id])
	end

	def update
		@account = Account.find_by_password_reset_token!(params[:id])
		if @account.password_reset_sent_at < 2.hours.ago
			redirect_to new_password_reset_path, :alert => "Password reset has expired."
		elsif params[:account][:password]
			#@account.update_attributes(:password => params[:password])
			@account.password = params[:account][:password]
			@account.password_confirmation = params[:account][:password_confirmation]
			@account.save!
			redirect_to root_url, :notice => "Password has been changed!"
		else
			render :edit
		end
	end

end
