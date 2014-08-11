class MailController < ApplicationController
	def mail_account
  		if(params[:from_person_id])
			@type_of_attachment = "person"
		else
			@type_of_attachment = "project"
		end
	 	if (params[:to_project_id])
		 	@project_id = params[:project_id]
		 	@project = Project.where(:id => @project_id)
		 	if(@project[0][:show_project] == 0)
		 		head :unauthorized
		 	else
		 		@to_account_id = @project[0][:account_id]
		 		@attachment = @project
		 	end
		else
			@person_id = params[:to_person_id]
		 	@person = Person.where(:id => @person_id)
		 	if(@person[0][:show_profile] == 0)
		 		head :unauthorized
		 	else
		 		@to_account_id = @person[0][:account_id]
		 		@attachment = @person
		 	end
		end
		@to_mail = Account.where(:id => @to_account_id)[0][:username]
	  	authenticate_or_request_with_http_token do |token, options|
	  		@from_account = ApiToken.where(access_token: token) 
	  		@from_mail = @from_account[0][:username]
			Mailer.mail_account(@from_mail,
				@to_mail, @type_of_attachment, @attachment).deliver
		end
 	end
end
