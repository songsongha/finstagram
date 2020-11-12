get '/' do
    # reads the index.html file in app/views
  File.read(File.join('app/views', 'index.html'))
end

get '/login' do
    "Login Page"
end
 