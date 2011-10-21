class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Timestamps
  plugin MongoMapper::Devise

  devise :database_authenticatable, :confirmable, :lockable, 
         :recoverable, :rememberable, :registerable, :trackable, 
         :timeoutable, :validatable, :token_authenticatable

  attr_accessible 	:email, :password, :password_confirmation, :remember_me, 
  					:first_name, :last_name, :active, :role
 
  key :first_name,     	String
  key :last_name,      	String
  key :username,      	String

  timestamps!

  # Validations.
  validates_presence_of :first_name, :last_name, :username
  
end
