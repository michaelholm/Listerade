class Page
  include MongoMapper::Document

  key :name, String
  key :content, String
  key :published, Boolean

end
