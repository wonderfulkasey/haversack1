class UserController < AppController

  #added code skeleton
 get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else
      redirect to('/items')
    end
  end

  post '/signup' do
    @user = User.new(params)
    if !@user.save
      @errors = @user.errors.full_messages
      erb :'users/signup'
    else
      session[:user_id] = @user.id
      redirect to('/items')
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to('/items')
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to('/items')
    else
      @errors = "Invalid username or password."
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?
      @user = current_user
      @user = nil
      session.destroy
      redirect to('/')
    else
      redirect to('/')
    end
  end

end
