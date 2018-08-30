module ApplicationHelper
  def current_user
    @current_user.presence
  end
end
