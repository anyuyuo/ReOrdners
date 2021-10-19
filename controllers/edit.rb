require './models/document'

get '/edit/:id' do
    # TODO: make sure id is nummeric
    @doc = Document.load params[:id]

    erb :edit
end
