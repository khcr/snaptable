module Snaptable
  module Constructor
    module Collection

      def collection
        @collection ||= if Snaptable.use_permission 
          current_permission.records(params[:controller], model, @token)
        else
          model
        end.includes(belongs_to_associations)
      end

      def records
        @records ||= filter(collection).paginate(page: params[:page], per_page: 30).order(sort_column + " " + sort_direction)
      end

      def filter(collection)
        if options[:search] == true && !params[:query].blank?
          collection.joins(search_associations).where(query, query: "%#{params[:query]}%", id: params[:query].to_i)
        else
          collection
        end
      end

      private

      def query
        query_fields.map do |key, values|
          values.map do |value|
            "#{key}.#{value} LIKE :query OR"
          end.join(" ")
        end.join(" ") + " #{column_name('id')} = :id"
      end

      def query_fields
        if self.class.const_defined?(:Search)
          self.class::Search.fields
        else
          { model.table_name => model.columns.select{ |c| c.type == :string }.map{ |c| c.name } }
        end
      end

      def search_associations
        self.class::Search.associations if self.class.const_defined?(:Search)
      end

      def belongs_to_associations
        model.reflect_on_all_associations(:belongs_to).map{ |a| a.name }
      end

    end
  end
end