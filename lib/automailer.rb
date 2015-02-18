# require 'rest_client'

module AutoMailer

	def send_email(subject, text)
		  RestClient.post "https://api:key-bd73d72bf3ad7a809db3316b37fcfc53"\
		  "@api.mailgun.net/v2/sandbox69718c6add8d47f0be16d79679aec711.mailgun.org/messages",
		  :from => "Mailgun Sandbox <postmaster@sandbox69718c6add8d47f0be16d79679aec711.mailgun.org>",
		  :to => self.email,
		  :subject => subject,
		  :text => text
	end


end


