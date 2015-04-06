module Snaptable
  module Constructor    
    module Renderer

      def present
        render_to_string('/base', layout: false, locals: { presenter: self }).html_safe
      end

      def respond
        respond_to do |format|
          format.html
          format.js { render '/sort' }
        end
      end

    end
  end
end