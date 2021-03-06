require 'sqlite3'
require 'sinatra'

class DB
    attr_reader :db
    def self.init debug = false
        if debug
            if File.exist?  "./test_database.db" then File.delete "./test_database.db" end
            db_exists = File.exist? '../test_database.db'
            @@db = SQLite3::Database.new 'test_database.db'
        else
            db_exists = File.exist? '../database.db'
            @@db = SQLite3::Database.new 'database.db'
        end
        @@db.results_as_hash = true

        # TODO: check whether db is set up
        return if db_exists
        full_sql = File.read('./db/create_db.sql')
        full_sql.gsub("\r", "").split("\n\n").each do |sql|
            begin
                @@db.execute sql
            rescue => exception
                puts exception            
            end
        end
        return true
    end

    def self.get_db
        if not defined? @@db then DB.init end
            
        return @@db
    end
end
