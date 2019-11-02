class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user, except: [:login, :logout, :create_session, :about]

  def about
  end

  def login
    redirect_to root_path if current_user.present?
  end

  def create_session
    user = Caretaker.find_by_email(params.dig(:login, :email))
                    &.authenticate(params.dig(:login, :password))
    if user.present?
      reset_session
      session[:current_user] = user.id
      redirect_to root_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def logout
    session.delete(:current_user)
    redirect_to root_path
  end

  def current_user
    return nil if session[:current_user].blank?
    @current_user ||= Caretaker.find(session[:current_user]) rescue nil
  end

  def current_organization
    return nil if current_user.blank?
    @current_organization ||= current_user.organization rescue nil
  end

  def check_admin
    return if current_user&.master?
    flash[:alert] = 'Permission Denied'
    redirect_back(fallback_location: root_path)
  end

  private
    def authenticate_user
      # session[:current_user] = ""
      # session[:current_user] = Matt.find.id
      current_organization   if current_user.present?
      redirect_to login_path unless current_user.present?
    end
end
