require './models/document'
require './models/doc'
require './models/image'

before '/upload' do
    if settings.use_login
	    redirect '/' unless session['logged_in']
    end
end

get '/upload' do
    erb :upload
end

post '/upload' do
    # check if actual files are being upoloaded
    unless params[:files]
        @error = 'Error uploading file: No Files uploaded'
        return erb :upload
    end

    # check files conditions
    params[:files].each do |file|
        unless file[:tempfile] && file[:filename]
            @error = 'Error uploading file: Broken file or something, try again, I guess'
        end
    end
    
    parent_id = nil
    first_img = nil

    # TODO: maybe save it rigt away at the .new stage?
    ndoc = NDocument.new
    ndoc.save

    params[:files].each do |file|
        # new method
        img = Image.new

        img.filename = file[:filename]
        img.mimetype = File.extname(file[:tempfile].path)
        img.save

        first_img = img.id if first_img == nil

        ndoc.append_image img
        
        new_path = "./public/uploads/image_#{img.id}#{img.mimetype}"
        FileUtils::Verbose.cp(file[:tempfile].path, new_path)

        # old method
        doc = Document.new
        doc.file_orig_name = file[:filename]
        doc.file_ext = File.extname(file[:tempfile].path)
        doc.save
        # set first item to parent
        parent_id = doc.id if parent_id == nil
        
        new_path = "./public/uploads/#{doc.id}#{doc.file_ext}"
        FileUtils::Verbose.cp(file[:tempfile].path, new_path)
    end

    ndoc.parent_img = first_img
    ndoc.update

    p "redirecting to #{parent_id}"
    redirect "/view/#{parent_id}"
end
