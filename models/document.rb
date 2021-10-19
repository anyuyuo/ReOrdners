require './db/sql'

class Document
    attr_accessor :id, :name, :scan_date
    attr_accessor :content, :description, :file_ext
    attr_accessor :file, :file_orig_name, :img_path
    # TODO: I think :file is not used anymore

    def initialize
        @id = nil
        @name = current_time = Time.now().strftime "%F %T"
        @scan_date = Time.now.to_i
        @content = ""
        @description = ""
        @file_ext = ""
        @file_orig_name = ""
    end

    def get_path
        "/uploads/#{self.id}#{self.file_ext}"
    end

    def save
        db = DB.get_db

        begin
            sql = db.execute "INSERT INTO Documents (name, scan_date, content, description, file_ext) VALUES
            (?, ?, ?, ?, ?)", [@name, @scan_date, @content, @description, @file_ext]
        rescue => exception
            $stderr.puts "Error: "  + exception.to_s
        end
        
        @id = db.last_insert_row_id
        return @id
    end

    def self.load id
        db = DB.get_db

        db_res = db.execute "SELECT name, scan_date, content, description, file_ext FROM Documents WHERE rowid=#{id}"
        
        return nil if (db_res.length < 1) 

        res = db_res[0]

        doc = Document.new
        doc.id = id
        doc.name = res["name"]
        doc.scan_date = res["scan_date"]
        doc.content = res["content"]
        doc.description = res["description"]
        doc.file_ext = res["file_ext"]

        return doc
    end

    def self.get_doc_count
        db = DB.get_db
        db.execute "SELECT COUNT(name) AS count FROM Documents"
    end

    def to_s
        str = ''
        str += "id: #{self.id}, "
        str += "name: #{self.name}, "
        str += "date: #{self.scan_date}, "
        str += "content: #{self.content}, "
    end
end
