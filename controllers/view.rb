require './models/document'

# view is basically the same as edit but with a restricted view
get '/view/:id' do
    # TODO: make sure id is nummeric
    @doc = Document.load params[:id]

    erb :edit
end
