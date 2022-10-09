class ContactFormsController < ApplicationController
  before_action :load_page, only: [:new, :create]
  invisible_captcha only: [:create], honeypot: :nickname

  def new
    @contact = ContactForm.new
  end

  def create
    @contact = ContactForm.new(contact_params)
    if @contact.valid?
      # send email
      ContactUsMailer.send_message(@contact).deliver_now
      flash[:notice] = I18n.t("contact_form.thank_you")
      redirect_to new_contact_form_path
    else
      render :new
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact_form).permit(:name, :email, :message, :nickname)
    end

    def load_page
      @page = Page.find_by_name(:contact) || Page.create!(name: :contact, body: "CONTACT administrator. Newly created page: contact")
    end

end
