class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Timestamps
  plugin MongoMapper::Devise
  plugin AttachIt
    
#   has_attachment :photo, {  
#   			:styles => { :small => '100x100>', :medium => '200x200>' } 
#   		}

  devise :database_authenticatable, :confirmable, :lockable, 
         :recoverable, :rememberable, :registerable, :trackable, 
         :timeoutable, :validatable, :token_authenticatable

  attr_accessible 	:email, :password, :password_confirmation, :remember_me, 
  					:first_name, :last_name, :active, :role, :friendship_ids, :friends
 
  key :first_name,     	String
  key :last_name,      	String
  key :username,      	String
  
  key :addr, 			String
  key :addr2, 			String
  key :city, 			String
  key :state, 			String
  key :zip, 			String
  key :country, 		String
  key :work_phone, 		String
  key :fax, 			String
  key :mobile_phone,	String
  key :home_phone, 		String
  key :company_name, 	String
  key :website,			String
  
  key :private_profile, Boolean
  key :breos_url, 		String
  key :description, 	String
  
  # favorite listings
  key :favorite_listings, Array
  
  many :saved_searches
  
  #key :friendship_ids, Array
  #many :friends, :in => :friendship_ids, :class_name => 'User'

  timestamps!
  
  # for dev purposes
  def username
  	"#{first_name}#{last_name}".gsub(' ', '').downcase
  end
  
  # User has many saved searches
  #many :saved_searches

  def friending(a_user)
    # self.push_uniq(:attendees => a_user.id)
    friendship_ids << a_user.id
    save
  end
  
  # Validations.
  #validates_presence_of :first_name, :last_name
  
#   def add_to_favorites(listing_id)
#   	# TODO - should validate the listing number is real before adding
#   	self.fave_listings << listing_id
#   	save
#   end
#   
#   def remove_from_favoritess(listing_id)
#   	self.favorite_listings.delete(listing_id)
#   	save
#   end
  
  
end
