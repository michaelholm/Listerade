class SavedSearch
	include MongoMapper::Document
	plugin MongoMapper::Plugins::Timestamps
	
	belongs_to :user
	
	#key :query, String, :required => true
	key :last_ran, Time
	
	key :property_type, String
	key :bathrooms, Float
	key :bedrooms, Integer
	key :price_low, Integer
	key :price_high, Integer
	key :built_min, Integer
	key :built_max, Integer
	key :zip, String
	
	key :location, String
	
	key :results_count, Integer
		
	timestamps!
end