class FindController < ApplicationController
  
  skip_before_filter :verify_authenticity_token 
 
  def index
  	
  end

  # Search for matching properties
  def search

  	parser = AddressParser.new
  	address_hash = {}
  	
  	unless params[:location].nil?
	  	if is_number?(params[:location]) then 
	  		# zip code
		  	address_hash = parser.zip.parse(params[:location])
		elsif params[:location].length == 2 then
			# state only
			params[:location] = params[:location].strip.upcase
			address_hash = parser.state.parse(params[:location])
		else
			# city, state, zip
			begin address_hash = parser.csz.parse(params[:location])
				rescue
				# city
			  	address_hash = parser.city1.parse(params[:location]) unless params[:location].nil?
			end 
		end
	end
	
	# new hash for search keys
	skeys = {}
	
	if address_hash[:city] then 
		skeys["CIT"] = /#{address_hash[:city]}/i
		params['city'] = address_hash[:city]
	end
	if address_hash[:city1] then 
		skeys["CIT"] = /#{address_hash[:city1]}/i
		params['city'] = address_hash[:city]
	end
  	if address_hash[:state] then 
  		skeys["STATE"] = "#{address_hash[:state]}" 
  		params['state'] = address_hash[:state]
  	end
  	if address_hash[:zip] then 
  		skeys["ZP"] = address_hash[:zip].to_s 
  		#params['zip'] = CGI::escape(address_hash[:zip])
  		params['zip'] = address_hash[:zip]
  	end
  	
  	if(params.has_key?('baths') ) then
  		skeys["BTH"] = "#{params[:baths].to_f}"
  	end
  	
  	if(params.has_key?('beds') ) then
  		skeys["BR"] = params[:beds].to_i
  	end

  	if(params.has_key?('minyear') ) then
  		skeys["BLT-MIN"] = params[:minyear].to_i
  	end
  	
  	if(params.has_key?('maxyear') ) then
  		skeys["BLT-MAX"] = params[:minyear].to_i
  	end
  	
  	if(params.has_key?('price_low') ) then
  		skeys["LP-MIN"] = params[:price_low].to_i
  	end
  	
  	if(params.has_key?('price_high') ) then
  		skeys["LP-MAX"] = params[:price_high].to_i
  	end
  	
  	if(params.has_key?('zipcode') ) then
  		skeys["ZP"] = params[:zipcode]
  	end
	
	query = {}

	skeys.each do |key, value|
		case key
			 when 'BTH'
			   query.merge!({ key.to_sym.gte => value.to_f })
			 when 'BR'
			   query.merge!({ key.to_sym.gte => value.to_i })
			 when 'BLT-MIN'
			 	if value.to_i > 0 then
			 		query.merge!({ 'BLT'.to_sym.gte => value.to_i })
			 	end
			 when 'BLT-MAX'
			 	if value.to_i > 0 then
			 		query.merge!({ 'BLT'.to_sym.lte => value.to_i })
			 	end
			 when 'LP-MIN'
			 	if value.to_i > 0 then
			 		query.merge!({ 'LP'.to_sym.gte => value.to_i })
			 	end
			 when 'LP-MAX'
			 	if value.to_i > 0 then
			 		query.merge!({ 'LP'.to_sym.lte => value.to_i })
			 	end
			 when 'ZP'
			 	if value != "" then
			 		query.merge!({ 'ZP'.to_sym.lte => value })
			 	end
			 when 'CIT', 'STATE', 'ZP'
			   query.merge!({ key.to_sym => value })
		 end
	end
		
  	@listings = Listing.where( query ).paginate({
		  :sort => :LP.desc,
		  :per_page => 10, 
		  :page     => params[:page],
		})
  	
  	render :template => 'find/search', :collection => @listings
  	  	
  end
  
  def find_by_tag
  	@listings = Listing.by_tag( params[:tag] ).paginate({
		  :sort => :LP.desc,
		  :per_page => 10, 
		  :page     => params[:page],
		})

  	
  	puts @listings
  	
  	render :template => 'find/search', :collection => @listings
  end
  
  def find_by_price
  
  	@listings = Listing.where( :LP.gte => params[:from_price], :LP.lte => params[:to_price] )
  	
  	render :template => 'find/search', :collection => @listings
  
  end
  
  # Find by Listing ID
  def find_by_ln
 	@listing = Listing.where(:LN => params[:ln]).first
 	puts @listing.inspect
 	
 	# get gmap for the property location
 	@gmaps = @listing.to_gmaps4rails unless @listing.nil?
 	puts "GMAPS JSON: #{@gmaps}"
 	
 	if @listing.nil? then
 		# catch non-existent listing numbers, redirect to home
 		redirect_to '/'
 	else
	 	render :template => 'listings/show'
   	end
   end
   
   def serializable_hash(options = {})
    super({:except => :password}.merge(options))
  end

end
