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
          if attribute.is_a?(Symbol) || attribute.is_a?(String)
            attr_value = element.send(attribute)
          else # a hash { model: :attribute }
            attr_value = element.send(attribute.keys[0]).send(attribute.values[0])
            attr_model = string_to_class(attribute.keys[0].to_s)
            attribute = attribute.values[0]
          end
          format(attribute, attr_value, attr_model)
        end
      end

      def format(attribute, attr_value, attr_model)
        attr_model ||= model
        if attr_value.is_a?(Date) || attr_value.is_a?(Time) || attr_value.is_a?(DateTime)
          attr_value = l(attr_value, format: :snaptable)
        elsif !attr_value.nil? && attribute.to_s.in?(enums(attr_model))
          attr_value = t("#{attr_model.model_name.i18n_key}.#{attribute.to_s.pluralize}.#{attr_value}")
        end
        attr_value = view_context.strip_tags(attr_value.to_s)
        attr_value = view_context.truncate(attr_value, length: 40) unless options[:truncate] == false
        return attr_value
      end

      def enums(model)
        model.defined_enums.keys
      end

      def string_to_class(string)
        begin
          return string.classify.constantize
        rescue NameError
          return nil
        end
      end

    end
  end
end
