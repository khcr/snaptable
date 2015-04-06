module Renderer

  def present
    render_to_string('/base', layout: false, locals: { presenter: self }).html_safe
  end

  def respond
    prepend_view_path 'app/tables/templates'
    respond_to do |format|
      format.html
      format.js { render '/sort' }
    end
  end

end