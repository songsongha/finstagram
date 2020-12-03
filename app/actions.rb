#get '/' do
    # reads the index.html file in app/views
 # File.read(File.join('app/views', 'index.html'))
#end


get '/' do
    
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    erb(:index)
end


get '/login' do
    "Login Page"
end
 
get '/signup' do
    @user = User.new #setup empty @user object
    erb(:signup) #render "app/view/signup.erb"
end

post '/signup' do
    #grabs user input values from params
    email = params[:email]
    avatar_url = params[:avatar_url]
    username = params[:username]
    password = params[:password]

    
    #instantiate and save a User
    @user = User.new({email: email, avatar_url: avatar_url, username: username, password:password})
    
    if @user.save
    #return readable represenation of User object
       "User #{username} saved!"

    else
        erb(:signup)
    end

end