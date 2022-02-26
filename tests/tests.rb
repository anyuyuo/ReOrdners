require './db/sql'
require './models/image'
require './models/document'

def prepare_db
    DB::init true
    db = DB.get_db

    img1 = Image.new
    img1.filename = 'testimage 1'
    img1.mimetype = 'png'
    img1.save

    img2 = Image.new
    img2.filename = 'testimage 2'
    img2.mimetype = 'png'
    img2.save

    begin
        sql = <<-SQL
            INSERT INTO document_new (rowid, name, creation_date, parent_img) VALUES (1000, "test number 1", 0, ?);
        SQL
        db.execute sql, img1.id

        # sql = <<-SQL
        #     INSERT INTO image (rowid, filename, mimetype, content) VALUES (10, "test image 1", "png", ""), (11, "test image 2", "png", "");
        # SQL
        # db.execute sql

        sql = <<-SQL
            INSERT INTO doc_img (doc_id, image_id) VALUES (1000, ?), (1000, ?);
        SQL
        db.execute sql, img1.id, img2.id
    rescue => e
        $stderr.puts "Error: "  + e.to_s
    end
end

def test_doc_img_db_select_by_document_id
    db = DB.get_db

    sql = <<-SQL
        SELECT *
        FROM doc_img
        WHERE doc_id=?
    SQL
    begin
        res = db.execute sql, 1000
    rescue => exception
        $stderr.puts "Error: "  + e.to_s
    end

    p res
end

prepare_db()

test_doc_img_db_select_by_document_id()