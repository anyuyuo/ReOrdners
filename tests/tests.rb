require './db/sql'
require './models/doc'
require './models/image'

def prepare_db
    DB::init true
    db = DB.get_db

    doc = NDocument.new
    doc.save

    img1 = Image.new
    img1.filename = 'testimage 1'
    img1.mimetype = 'png'
    img1.save

    img2 = Image.new
    img2.filename = 'testimage 2'
    img2.mimetype = 'png'
    img2.save

    doc.append_image img1, true
    doc.append_image img2

    doc.id
end

def test_doc_img_db_select_by_document_id id
    doc = NDocument.load id
    p doc
    images = doc.get_images
    p images
end

id = prepare_db()
test_doc_img_db_select_by_document_id(id)