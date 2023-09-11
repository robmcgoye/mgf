class ContactUsMailer < ApplicationMailer

  def send_message(contact_form)
    @contact = contact_form
    mail(to: CONFIG[:contact_form_email_to], subject: '[MGF] Contact Us Message')
  end

end
