module Collection

  def collection
    @collection ||= model.includes(belongs_to_associations)
  end

  def records
    @records ||= filter(collection).paginate(page: params[:page], per_page: 30).order(sort_column + " " + sort_direction)
  end

  def filter(collection)
    if options[:search] == true
      collection.joins(search_associations).where(query_fields, query: "%#{params[:query]}%", id: params[:query].to_i)
    else
      collection
    end
  end

  private

  def query_fields
    self.class::Search.fields.map do |key, values|
      values.map do |value|
        values.map{ |v| "#{key}.#{v} LIKE :query OR"}.join(" ")
      end
    end.join(" ") + " #{column_name('id')} = :id"
  end

  def search_associations
    self.class::Search.associations
  end

  def belongs_to_associations
    model.reflect_on_all_associations(:belongs_to).map{ |a| a.name }
  end

end