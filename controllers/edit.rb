require './models/document'

get '/edit/:id' do
    # TODO: make sure id is nummeric
    @doc = Document.load params[:id]
    @edit_enabled = true
    
    erb :edit
end

post '/edit/:id' do
  redirect "/view/#{params['id']}"
end

post '/edit/delete/:id' do
  Document.delete params[:id]
  redirect '/search'
end
