require './models/document'

get '/edit/:id' do
    # TODO: make sure id is nummeric
    @doc = Document.load params[:id]
    @edit_enabled = true
    
    erb :edit
end

post '/edit/:id' do
  logger.info params.to_s

  redirect '/' if !(defined? params[:name] || !(defined? params[:tags]))

  doc = Document.load params[:id]

  doc.name = params[:name]
  doc.description = params[:tags] #for now description, until I added an option for tags
  
  logger.info "Gonna update '#{doc.id}' with params '#{doc.name}' and '#{doc.description}'"

  success = doc.update
  logger.info "updating failed" if success == false

  redirect "/view/#{params[:id]}"
end

post '/edit/delete/:id' do
  Document.delete params[:id]
  redirect '/search'
end
