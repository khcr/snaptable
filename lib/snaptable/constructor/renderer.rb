module Snaptable
  module Constructor
    module Renderer

      def present(buttons: nil)
        @buttons = buttons || "snaptable/buttons"
        render_to_string('/snaptable/base', layout: false, locals: { presenter: self }).html_safe
      end

      def respond
        respond_to do |format|
          format.html
          format.js do
            render '/snaptable/sort', locals: { content: self.present(buttons: params[:buttons]) }
          end
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
          format(attribute, attr_value)
        end
      end

      def format(attribute, attr_value)
        if attr_value.is_a?(Date) || attr_value.is_a?(Time) || attr_value.is_a?(DateTime)
          attr_value = l(attr_value, format: :snaptable)
        elsif !attr_value.nil? && attribute.to_s.in?(enums)
          attr_value = t("#{model.model_name.i18n_key}.#{attribute.to_s.pluralize}.#{attr_value}")
        end
        attr_value = view_context.strip_tags(attr_value.to_s)
        attr_value = view_context.truncate(attr_value, length: 40) unless options[:truncate] == false
        return attr_value
      end

      def enums
        model.defined_enums.keys
      end

    end
  end
end
