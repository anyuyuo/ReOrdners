require 'sinatra'
require './db/sql'

Dir["./controllers/*.rb"].each {|file| require file}

configure do
    # server settings
    set :bind, '0.0.0.0'
    set :port, 6789
    enable :sessions
    
    set :purge_db, true
    set :use_login, false
    
    # TODO: set up database
    if (settings.purge_db) and File.exist?  "./database.db" then File.delete "./database.db" end
    DB::init
end

get '/' do
    db = DB.get_db
    
    erb :index
end
