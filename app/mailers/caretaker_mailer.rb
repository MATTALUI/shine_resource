class CaretakerMailer < ApplicationMailer
  # def test
  #   return mail(to: 'example@email.com', subject: "This is a test.")
  # end

  def new_caretaker_mail
    @caretaker = params[:caretaker]
    @email = @caretaker.email
    @current_user = params[:current_user]
    @organization = @current_user.organization
    @token = params[:token]
    return mail(to: @email, subject: "Welcome to #{@organization}.")
  end
end
