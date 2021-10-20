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
    # later redirect to /edit/{id} of newly uploaded file
    unless params[:file] &&
            (tempfile = params[:file][:tempfile]) &&
            (name = params[:file][:filename])

        @error = 'Error uploading file: No File selected'
        return erb :upload
    end
    
    doc = Document.new

    doc.file_orig_name = name
    doc.file_ext = File.extname(params[:file][:tempfile].path)
    doc.save
    
    new_path = "./public/uploads/#{doc.id}#{doc.file_ext}"
    FileUtils::Verbose.cp(tempfile.path, new_path)

    redirect "/edit/#{doc.id}"
end
