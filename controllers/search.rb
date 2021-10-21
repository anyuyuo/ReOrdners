require './models/document'

get '/search' do
  if defined? params[:search]
    sql = "some sql"
  end

  @docs = Document.load_batch

  erb :search
end

