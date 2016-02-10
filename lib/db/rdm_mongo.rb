require 'rubygems'
require 'mongo'

db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'rdm_db')

# result = db[:artists].insert_one({ name: 'FKA' })
# result = db[:artists].insert_one({ name: 'FKA' })
# result = db[:artists].insert_one({ name: 'FKA' })
# result.n #=> returns 1, because 1 document was inserted.

db[:artists].find().each do |document|
	puts document
end	
