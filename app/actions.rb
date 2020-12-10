#get '/' do
    # reads the index.html file in app/views
 # File.read(File.join('app/views', 'index.html'))
#end
helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

get '/' do
    
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    
    erb(:index)
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
       redirect to('/login')

    else
        erb(:signup)
    end

end

get '/login' do
    
    erb(:login) # render app/views/login.erb
end

post "/login" do
    username = params[:username]
    password = params[:password] #the key :password is refering to the name label in the form
    
    # find user by username
    @user = User.find_by(username: username)
    
    if @user && @user.password == password
        session[:user_id] = @user.id
            redirect to('/')
    else
        @error_message = "Login failed."
        erb(:login)
    end

end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
    "Logout successful"
end


get '/finstagram_posts/new' do
    @finstagram_post = FinstagramPost.new
    erb(:"finstagram_posts/new")
end

post '/finstagram_posts' do
    photo_url = params[:photo_url]

    #instantiate new FinstagramPost
    @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

    #if @post validates, save
    if @finstagram_post.save
        redirect(to('/'))
    else
        erb(:"finstagram_posts/new")
    end
end

get '/finstagram_posts/:id' do
    @finstagram_post = FinstagramPost.find(params[:id])
    erb(:"finstagram_posts/show")
end