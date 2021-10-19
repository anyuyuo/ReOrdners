require 'sinatra'
require './controllers/upload.rb'
require './conf'
require './db/sql'

# server settings
set :bind, '0.0.0.0'
set :port, 6789
enable :sessions

set :use_login, false
set :purge_db, true

configure do
    
    # TODO: set up database
    if (settings.purge_db) then File.delete "./database.db" end
    DB::init

end

get '/' do
    db = DB.get_db
    
    res = db.execute "SELECT * FROM Tags;"
    logger.info res

    erb :index
end
