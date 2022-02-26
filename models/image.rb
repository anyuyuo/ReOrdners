require './db/sql'

class Image
    attr_accessor :id
    attr_accessor :filename
    attr_accessor :mimetype
    attr_accessor :content
    # :path is not needed since it will be static

    def initialize
        @filename = ''
        @mimetype = ''
        @content = ''
    end

    def getDocument

    end
    
    def setAsParent

    end
    
    def save
        # reutrn nil if null in case of error
        if @filename == nil or @mimetype == nil
            raise 'Image save error: Values must not be nil'
            return nil
        end

        db = DB.get_db

        begin
            sql = <<-SQL
                INSERT INTO image (filename, mimetype)
                VALUES (?, ?)
            SQL

            db.execute sql, @filename, @mimetype
        rescue => exception
            $stderr.puts "Error: "  + exception.to_s
            return nil
        end

        @id = db.last_insert_row_id
    end

    def update

    end

    def delete

    end

    def is_parent
        db = DB.get_db

        begin
            sql = <<-SQL
                SELECT COUNT(rowid)
                FROM document_new
                WHERE parent_img = ?
            SQL

            res_arr = db.execute sql @id

        rescue => exception
            $stderr.puts "Error: "  + exception.to_s
            return nil
        end

        return res_arr.length > 0
    end

    def self.create_from_obj obj
        img = Image.new
        img.id = obj["rowid"]
        img.filename = obj["filename"]
        img.mimetype = obj["mimetype"]
        img.content = obj["content"]
        return img
    end
end
