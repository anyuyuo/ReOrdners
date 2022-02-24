require './db/sql'

class Document
    attr_accessor :id
    attr_accessor :name
    attr_accessor :creation_date

    attr_accessor :scan_date
    attr_accessor :content
    attr_accessor :description
    attr_accessor :file
    attr_accessor :file_ext
    attr_accessor :file_orig_name
    attr_accessor :img_path
    # TODO: I think :file is not used anymore

    def initialize
        @id = nil
        @name = current_time = Time.now().strftime "%F %T"
        @creation_date = Time.now.to_i

        @scan_date = Time.now.to_i
        @content = ""
        @description = ""
        @file_ext = ""
        @file_orig_name = ""
    end

    def get_path
        "/uploads/#{self.id}#{self.file_ext}"
    end

    def update
        db = DB.get_db

        begin
            sql = <<-SQL
                UPDATE Documents
                SET
                    name=?,
                    description=?
                WHERE
                    rowid=?
            SQL
            db.execute sql, [@name, @description, @id]
        rescue => exception
            # todo: raise or return false?
            # raise "Error: "  + exception.to_s
            return false
        end
        
        return true
    end

    def save
        db = DB.get_db

        begin
            sql = db.execute "INSERT INTO Documents (name, scan_date, content, description, file_ext) VALUES
            (?, ?, ?, ?, ?)", [@name, @scan_date, @content, @description, @file_ext]
        rescue => exception
            # todo: don't puts here, rather return an error
            $stderr.puts "Error: "  + exception.to_s
        end
        
        @id = db.last_insert_row_id
        return @id
    end

    def self.delete id
      db = DB.get_db
      sql = db.execute "DELETE FROM Documents WHERE rowid=#{id}"
    end

    def self.create_doc obj
        doc = Document.new
        doc.id = obj["id"]
        doc.name = obj["name"]
        doc.scan_date = obj["scan_date"]
        doc.content = obj["content"]
        doc.description = obj["description"]
        doc.file_ext = obj["file_ext"]
        return doc
    end

    def self.load id
        db = DB.get_db

        db_res = db.execute "SELECT name, scan_date, content, description, file_ext FROM Documents WHERE rowid=#{id}"
        
        return nil if (db_res.length < 1) 

        res = db_res[0]
        
        res["id"] = id
      
        return self.create_doc res
    end

    def self.load_batch offset=0, batch_count=nil
        db = DB.get_db
        if defined? batch_count
          # TODO: some something about it
        end

        sql = "SELECT rowid AS id, name, scan_date, content, description, file_ext \
          FROM Documents"
        res = db.execute sql
        docs = []
        res.each do |doc|
          docs.push self.create_doc doc
        end

        return docs
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
