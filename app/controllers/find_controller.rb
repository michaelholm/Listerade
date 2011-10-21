class FindController < ApplicationController
  
  skip_before_filter :verify_authenticity_token 
 
  def index
  	
  end

  # Search for matching properties
  def search
  	# @criteria = params.to_json
  	# here we'll want to execute a find
  	# {"homepage_submit":"","address":"chicago","action":"search","property_type":"Residential","controller":"find"}
  	
  	# Handy tip to find a random listing item: Listing.all(:limit => 1, :skip => rand(Listing.count())).fields(:LN, :LP, :ZP)
  	# Cities in sample data:
	# 	  	"EVANSTON",
	# 		"SKOKIE",
	# 		"Chicago",
	# 		"CHICAGO",
	# 		"HIGHLAND PARK",
	# 		"Evanston",
	# 		"WILMETTE",
	# 		"PROSPECT HEIGHTS",
	# 		"BUFFALO GROVE",
	# 		"MORTON GROVE",
	# 		"NORTHFIELD",
	# 		"GLENVIEW",
	# 		"LINCOLNWOOD",
	# 		"DES PLAINES",
	# 		"FLOSSMOOR",


  	parser = AddressParser.new
  	if is_number?(params[:address]) then 
	  	address_hash = parser.zip.parse(params[:address]) 
	else
		begin address_hash = parser.csz.parse(params[:address])
			rescue
		  	address_hash = parser.city1.parse(params[:address]) unless params[:address].nil?
		end 
	end
	
	# new hash for search keys
	skeys = {}

	if address_hash[:city] then skeys["CIT"] = /#{address_hash[:city]}/i end
	if address_hash[:city1] then skeys["CIT"] = /#{address_hash[:city1]}/i end
  	if address_hash[:state] then skeys["STATE"] = "#{address_hash[:state]}" end
  	if address_hash[:zip] then
  		zip = address_hash[:zip]
  		skeys["ZP"] = "#{zip}" 
  	end
  	  	
  	#skeys = skeys[0..-1].to_s
  	#  skeys.symbolize_keys.inspect[1..-2]
  	@listings = Listing.where( skeys.to_mongo ).paginate({
		  :sort => :LP.desc,
		  :per_page => 15, 
		  :page     => params[:page],
		})
  	
  	render :template => 'find/search', :collection => @listings
  	  	
  end
  
  def find_by_price
  
  	@listings = Listing.where( :LP.gte => params[:from_price], :LP.lte => params[:to_price] )
  	
  	render :template => 'find/search'
  
  end
  
  # Find by Listing ID
  def find_by_ln
 	@listings = Listing.where(:LN => params[:ln]).fields(:LN, :RE1, :RE2, :RE3).all
 	
 	render :template => 'find/search'
  end

end
