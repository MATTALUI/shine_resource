module ApplicationHelper
  def current_user
    @current_user.presence
  end

  def render_haml(haml, locals={})
    return Haml::Engine.new(haml.strip_heredoc, format: :html5).render(self, locals)
  end
end
