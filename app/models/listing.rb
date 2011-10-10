class Listing
  include MongoMapper::Document

  key :addr, String
  key :addr2, String
  key :city, String
  key :state, String
  key :zip_code, String
  key :listing_id, Integer
  key :list_price, Integer
  
end
