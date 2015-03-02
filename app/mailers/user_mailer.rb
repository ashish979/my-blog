class UserMailer < ApplicationMailer
	default from: "ashishagrawal979@gmail.com"

	def welcome_email(user)
		@user = user
		@url = "http://www.payu.in"
		mail(to: "ashish.agrawal@payu.in", subject: "welcome to payu india")
	end
end
