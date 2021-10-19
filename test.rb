require './models/document'
require './db/sql'

doc = Document.new
doc.save

db = DB.get_db
puts db.execute 'SELECT COUNT(name) AS count FROM documents'
