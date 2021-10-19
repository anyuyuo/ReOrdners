require './models/document'

before '/upload' do
    logger.info 'checking if logged in. Need to use?: ' + settings.use_login.to_s
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

        @error = 'Error uploading file'
        return erb :upload
    end
    
    doc = Document.new
    doc.file = 

    current_time = Time.now().strftime "%F %T"
    file_ext = File.extname(params[:file][:tempfile].path)

    # TODO: check for allowed file extensions only
    db = DB.get_db
    db.execute "INSERT INTO Documents (name, image_ext, creation_time) VALUES
		('#{current_time}', '#{file_ext}', #{Time.now.to_i})"

    last_id = db.last_insert_row_id
    
    
    new_file_path = "#{config[:doc_dir]}#{last_id}#{file_ext}"
    FileUtils::Verbose.cp(tempfile.path, new_file_path)
    redirect "/edit/#{last_id}"
end
