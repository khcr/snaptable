class BaseTable < SimpleDelegator
	include Sortable
	include Collection
	include Renderer

	def initialize(parent, collection = nil, options = {})
		super(parent)
		@collection = collection
		@options = options
		@token = stored_token
	end

	def options
		@options
	end

	def column_names
		model.column_names
	end

	def url(e)
		e.id
	end

	def values(element)
		attributes.map do |attribute|
			if attribute.is_a? Symbol 
				element.send(attribute)
			else
				element.send(*attribute.keys).send(*attribute.values)
			end.to_s
		end
	end

	private

	def stored_token
    session[:token] = params[:token] if params[:token]
    return session[:token]
  end

end