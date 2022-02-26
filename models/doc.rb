require './db/sql'

class NDocument
    attr_accessor :id
    attr_accessor :name
    attr_accessor :creation_date
    attr_accessor :parent_img
    # TODO: I think :file is not used anymore

    def initialize
        @id = nil
        @name = current_time = Time.now().strftime "%F %T"
        @creation_date = Time.now.to_i
        @parent_img = nil # parent image id
    end

    def update
        db = DB.get_db

        begin
            sql = <<-SQL
                UPDATE document_new
                SET
                    name=?,
                    parent_img=?
                WHERE
                    rowid=?
            SQL
            db.execute sql, [@parent_img, @id]
        rescue => exception
            # todo: raise or return false?
            # raise "Error: "  + exception.to_s
            return nil
        end
        
        return true
    end

    def append_image image, make_parent = false
        # null check
        return nil if @id == nil or image == nil or image.id == nil

        @parent_img = image.id

        db = DB.get_db
        
        begin
            sql = <<-SQL
                INSERT INTO doc_img (doc_id, image_id)
                VALUES (?, ?)
            SQL

            res = db.execute sql, @id, image.id
        rescue => exception
            p exception.backtrace
            $stderr.puts "Error appendig image to document: "  + exception.to_s
            return nil
        end
        return true
    end

    def save
        if @name == nil
            return nil
        end
        db = DB.get_db

        begin
            sql = db.execute "INSERT INTO document_new (name, creation_date, parent_img) VALUES
            (?, ?, ?)", [@name, @creation_date, @parent_img]
        rescue => exception
            # todo: don't puts here, rather return an error
            $stderr.puts "Error saving document: "  + exception.to_s
        end
        
        @id = db.last_insert_row_id
    end

    def self.delete id
      db = DB.get_db
      sql = db.execute "DELETE FROM document_new WHERE rowid=#{id}"
    end

    def self.create_from_obj obj
        doc = Document.new
        doc.id = obj["id"]
        doc.name = obj["name"]
        doc.scan_date = obj["creation_date"]
        doc.content = obj["parent_id"]
        return doc
    end

    def self.load id
        db = DB.get_db

        db_res = db.execute "SELECT name, creation_date, parent_img FROM document_new WHERE rowid=#{id}"
        
        return nil if (db_res.length < 1) 

        res["id"] = id
        p res
        return Document::create_from_obj db_res[0]
    end

    def self.get_doc_count
        db = DB.get_db
        db.execute "SELECT COUNT(rowid) AS count FROM document_new"
    end

    def to_s
        str = ''
        str += "id: #{@id}, "   
        str += "name: #{@name}, "
        str += "parent: #{parent_img}"
    end
end
