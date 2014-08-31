class MailController < ApplicationController
	def mail_account

		puts "Obviously working"
		source_addr = nil
		dest_acc = get_dest_account
		dest_addr = dest_acc.username
		attachment = get_attachment
		authenticate_or_request_with_http_token do |token, options|
			source_acc = Account.where_token(token)
			source_addr = source_acc.username
			source_acc.id == attachment.account_id
		end
		attachment = attachment.attributes.except!('id', 'account_id', 'show_profile', 'image')
		Mailer.mail_account(attachment, source_addr, dest_addr).deliver
	end

	private

	def get_dest_account
		if params[:to_project_id]
			account = Account.where_project(params[:to_project_id]).first
		elsif params[:to_person_id]
			account = Account.where_person(params[:to_person_id]).first
		end
	end

	def get_attachment
		if params[:attach_person_id]
			attachment = Person.where(:id => params[:attach_person_id]).first
		elsif params[:attach_project_id]
			attachment = Project.where(:id => params[:attach_project_id]).first
		end
	end
end
