require './models/document'

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
    
    params[:files].each do |file|
        doc = Document.new

        doc.file_orig_name = file[:filename]
        doc.file_ext = File.extname(file[:tempfile].path)
        doc.save
        
        new_path = "./public/uploads/#{doc.id}#{doc.file_ext}"
        FileUtils::Verbose.cp(file[:tempfile].path, new_path)

        redirect "/view/#{doc.id}"
    end
end
