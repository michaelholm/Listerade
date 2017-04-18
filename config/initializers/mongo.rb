#require 'mongo_mapper' # loading mongo_mapper

#Choose a connection
#MongoMapper.connection = Mongo::Connection.new('localhost', 27017, :logger => Rails.logger)
#MongoMapper.connection = Mongo::Connection.from_uri('', :logger => Rails.logger)

#SET database name
#MongoMapper.database = ""

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
