module Snaptable
  module Constructor    
    module Renderer

      def present(buttons: nil)
        render_to_string('/snaptable/base', layout: false, locals: { presenter: self, buttons: buttons}).html_safe
      end

      def respond
        respond_to do |format|
          format.html
          format.js { render '/snaptable/sort' }
        end
      end

      def attributes
        model.attribute_names
      end

      def column_names
        attributes.map do |a|
          (a.is_a?(Hash) ? a.keys[0] : a).to_s
        end
      end

      def values(element)
        attributes.map do |attribute|
          attr_value = if attribute.is_a?(Symbol) || attribute.is_a?(String)
            element.send(attribute)
          else
            element.send(*attribute.keys).send(*attribute.values)
          end
          format_if_date(attr_value)
        end
      end

      def format_if_date(attr_value)
        if attr_value.is_a?(Date) || attr_value.is_a?(Time) || attr_value.is_a?(DateTime)
          attr_value.strftime("%d.%m.%y %H:%M")
        else
          attr_value
        end.to_s
      end

    end
  end
end