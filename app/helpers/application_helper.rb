module ApplicationHelper
  def current_user
    @current_user.presence
  end

  def render_haml(haml, locals={})
    return Haml::Engine.new(haml.strip_heredoc, format: :html5).render(self, locals)
  end

  def fa_icon(icon)
    return render_haml <<-ICON, icon: icon
      %i.fas{class: ("fa-"+icon)}
    ICON
  end
end
