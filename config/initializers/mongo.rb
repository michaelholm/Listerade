#require 'mongo_mapper' # loading mongo_mapper

#MongoMapper.connection = Mongo::Connection.new('localhost', 27017, :logger => Rails.logger)
MongoMapper.connection = Mongo::Connection.from_uri('mongodb://heroku_app1097050:kfi5tr5lf2eculchdnbn8chlvv@dbh63.mongolab.com:27637/heroku_app1097050', :logger => Rails.logger)
MongoMapper.database = "heroku_app1097050"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
