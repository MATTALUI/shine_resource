class CaretakerMailer < ApplicationMailer
  def new_caretaker_mail
    @caretaker = params[:caretaker]
    @email = @caretaker.email
    @current_user = params[:current_user]
    @organization = @current_user.organization
    @token = params[:token]
    return mail(to: @email, subject: "Welcome to #{@organization}.")
  end
end
