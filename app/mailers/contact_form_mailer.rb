class ContactFormMailer < ActionMailer::Base
  default from: ENV['default_email'] || 'mrgenixus+list-me@herokuapp.com'

  def incoming_message membership_id
    @membership = Membership.find(membership_id)

    mail(to: @membership.list.incoming_message_email, subject: "#{@membership.name} just signed up to #{@membership.list.name}" )
  end
end
