module Snaptable
  module Constructor
    module Sortable

      def sortable(column)
        if model.reflect_on_association(column.gsub /_id/, '').nil?
          view_context.link_to({sort: column, direction: direction(column), query: params[:query], paginate_key => page, table: table_name, buttons: @buttons}, {class: css_class(column)}) do
            model.human_attribute_name(column)
          end
        else
          model.human_attribute_name(column)
        end
      end

      def sort_column
        column_names.include?(params[:sort]) ? column_name(params[:sort]) : column_name("id")
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
      end

      def page
        params[paginate_key] || 1
      end

      def css_class(column)
        column_name(column) == sort_column ? "current #{sort_direction}" : nil
      end

      def direction(column)
        column_name(column) == sort_column && sort_direction == "asc" ? "desc" : "asc"
      end

      private

      def column_name(column)
        "#{model.table_name}.#{column}"
      end

    end
  end
end
