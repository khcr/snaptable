require 'snaptable/constructor/base_table'

module Snaptable
	module Helpers
		module TableHelper
			class Table < Snaptable::Constructor::BaseTable

				def initialize(parent, model, collection = nil, options = {})
          @model = model
					super(parent, collection, options)
				end

				def model
					@model
				end

        def table_name
          model.model_name.singular
        end

			end
		end
	end
end
