class MailController < ApplicationController
	before_filter :restrict_create

	def mail_account
		to_person = params.has_key?(:to_person_id) #To person? If not send to project
		attach_person = params.has_key?(:attach_person_id) #Attach person? If not attach project

		source_addr = @user_account.username
		dest_acc = get_details(to_person, params[:to_person_id] || params[:to_project_id]).account
		dest_addr = dest_acc.username
		attachment = get_details(attach_person, params[:attach_person_id] || params[:attach_project_id])

		#Compare the Token's userid with what the user wants to send
		if @user_account.id == attachment.account_id
			attachment = attachment.attributes.except!('id', 'account_id', 'show_profile', 'image')
			Mailer.mail_account(attachment, source_addr, dest_addr).deliver
		else
			head :unauthorized
		end
	end

	private

	def get_details (person, id)
		if person
			Person.find(id)
		else
			Project.find(id)
		end
	end

end
