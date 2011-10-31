class FindController < ApplicationController
  
  skip_before_filter :verify_authenticity_token 
 
  def index
  	
  end

  # Search for matching properties
  def search

  	parser = AddressParser.new
  	address_hash = {}
  	
  	unless params[:address].nil?
	  	if is_number?(params[:address]) then 
	  		# zip code
		  	address_hash = parser.zip.parse(params[:address])
		elsif params[:address].length == 2 then
			# state only
			params[:address] = params[:address].strip.upcase
			address_hash = parser.state.parse(params[:address])
		else
			# city, state, zip
			begin address_hash = parser.csz.parse(params[:address])
				rescue
				# city
			  	address_hash = parser.city1.parse(params[:address]) unless params[:address].nil?
			end 
		end
	end
	
	# new hash for search keys
	skeys = {}
	
	if address_hash[:city] then 
		skeys["CIT"] = /#{address_hash[:city]}/i
		params['city'] = CGI::escape(address_hash[:city])
	end
	if address_hash[:city1] then 
		skeys["CIT"] = /#{address_hash[:city1]}/i
		params['city'] = CGI::escape(address_hash[:city])
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
  	
  	# TODO: currently does only equal match, need to add greater than and less than capability
  	if(params.has_key?('baths') ) then
  		skeys["BTH"] = "#{params[:baths]}"
  	end
  	
  	if(params.has_key?('beds') ) then
  		skeys["BR"] = params[:beds]
  	end
  	# END TODO
  	
  	#skeys = skeys[0..-1].to_s
  	#  skeys.symbolize_keys.inspect[1..-2]
  	@listings = Listing.where( skeys.to_mongo ).paginate({
		  :sort => :LP.desc,
		  :per_page => 15, 
		  :page     => params[:page],
		})
  	
  	#params.delete :address
  	params.delete :homepage_submit
  	
  	render :template => 'find/search', :collection => @listings
  	  	
  end
  
  def find_by_price
  
  	@listings = Listing.where( :LP.gte => params[:from_price], :LP.lte => params[:to_price] )
  	
  	render :template => 'find/search'
  
  end
  
  # Find by Listing ID
  def find_by_ln
 	@listing = Listing.where(:LN => params[:ln]).first
 	
 	@gmaps = @listing.to_gmaps4rails unless @listing.nil?
 	puts "GMAPS JSON: #{@json}"
 	
 	if @listing.nil? then
	 	@listings = Listing.paginate({
			  :sort => :LP.desc,
			  :per_page => 15, 
			  :page     => params[:page],
			})
 		render :template => 'home/index'
 	else
	 	render :template => 'listings/show'
   	end
   end

end
