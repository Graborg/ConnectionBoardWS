class Mailer < ActionMailer::Base
	default from: "noreply@connectionboard.se"

	def welcome_email(account)
		@account = account
		@url  = 'http://54.191.168.116:3001/accounts/login'
		mail(to: @account.username, subject: 'Welcome to ConnectionBoard')
	end

	def mail_account(attachment, source_addr, dest_addr)
		@from = source_addr
		@attachment = attachment
		@attachment_title = attachment.values.first
		subject = "ConnectionBoard: #{@attachment_title} wants to make contact!"
		mail(to: dest_addr, subject: subject)
	end

	def password_reset(account)
		@account = account
		mail(:to => account.username, :subject => "Connection Board password Reset")
	end

	def mail_feedback(feedback, user, developer)
		@user = user
		@feedback = feedback
		mail(:to => developer, :subject => "Feedback from #{user}")
	end
end
