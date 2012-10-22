module KnowsAboutInstences
	def count
		@all_artists.length
	end
	def all
		@all_artists ||= []
	end
end