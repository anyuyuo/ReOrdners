require './db/sql'

class Image
    attr_accessor :id
    attr_accessor :filename
    attr_accessor :mimetype
    attr_accessor :content
    # :path is not needed since it will be static

    def initialize
        self.filename = ''
        self.mimetype = ''
        self.content = ''
    end

    def getDocument

    end
    
    def setAsParent

    end
    
    def save
        # reutrn nil if null in case of error
        if self.filename == nil or self.mimetype == nil
            raise 'Image save error: Values must not be nil'
            return nil
        end

        db = DB.get_db

        begin
            sql = <<-SQL
                INSERT INTO image (filename, mimetype)
                VALUES (?, ?)
            SQL

            db.execute sql, self.filename, self.mimetype
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

            res_arr = db.execute sql self.id

        rescue => exception
            $stderr.puts "Error: "  + exception.to_s
            return nil
        end

        return res_arr.length > 0
    end
end
