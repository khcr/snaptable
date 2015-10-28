require 'snaptable/constructor/base_table'

module Snaptable
	module Helpers
		module TableHelper
			class Table < Snaptable::Constructor::BaseTable

				def initialize(parent, model, collection = nil, options = {})
					super(parent, collection, options)
					@model = model
				end

				def model
					@model
				end

			end
		end
	end
end