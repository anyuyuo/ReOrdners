require './db/sql'

class Document
    attr_accessor :id, :name, :scan_date
    attr_accessor :content, :description, :file_ext
    attr_accessor :file

    def initialize
        @name = current_time = Time.now().strftime "%F %T"
        @scan_date = Time.now.to_i
        @content = ""
        @description = ""
        @file_ext = ""
    end

    def save
        db = DB.get_db

        begin
            sql = db.execute "INSERT INTO Documents (name, scan_date, content, description, file_ext) VALUES
            (?, ?, ?, ?)", [@name, @scan_date, @content, @description, @file_ext]
        rescue => exception
            puts exception
        end

        @id = db.last_insert_row_id
        puts db.execute 'SELECT * FROM Documents'
    end
end
