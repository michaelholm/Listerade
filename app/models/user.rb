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
  					:first_name, :last_name, :active, :role
 
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
  

  timestamps!

  # Validations.
  #validates_presence_of :first_name, :last_name
  
end
