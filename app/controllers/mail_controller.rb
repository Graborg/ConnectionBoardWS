class MailController < ApplicationController
	before_filter :restrict_create

	@@admin_mapping = {1 => "IOS", 2 => "WP", 3 => "Android", 4 => "Web"}

	def mail_account

		rec_is_person = params.has_key?(:to_person_id) #To person? If not send to project
		sender_is_person = params.has_key?(:attach_person_id) #Attach person? If not attach project

		source_addr = @token_account.username
		dest_acc = get_details(rec_is_person, params[:to_person_id] || params[:to_project_id]).account
		dest_addr = dest_acc.username
		attachment = get_details(sender_is_person, params[:attach_person_id] || params[:attach_project_id])


		first_mail = first_mail_today?(@token_account.id, dest_acc.id) || true #params.has_key?(:devmode)
		#Compare the sender's token's userid
		# with who the user gives out to be && check if spam or not
		if @token_account.id == attachment.account_id && first_mail
			attachment = attachment.attributes.except!('id', 'account_id', 'show_profile', 'image')
			Mailer.mail_account(attachment, source_addr, dest_addr).deliver
			MailLog.new(:from_id => @token_account.id, :to_id => dest_acc.id).save!
			render :json => "Successfully sent email from #{source_addr} to #{dest_addr}"
		else
			head :unauthorized
		end
	end

	def mail_feedback
		source_addr = @token_account.username
		developer = @@admins.fetch(@@admin_mapping.fetch(params[:OS]))
		Mailer.mail_feedback(params[:feedback], source_addr, developer).deliver
		render :json => "Successfully sent email from #{source_addr} to #{developer}"
	end

	private

	def get_details (person, id)
		if person
			Person.find(id)
		else
			Project.find(id)
		end
	end

	def first_mail_today?(from_id, to_id)
		last_mail = MailLog.where(from_id: from_id, to_id: to_id).order(:created_at).last
		return last_mail.nil? || last_mail.created_at > 1.day.from_now
	end

end
