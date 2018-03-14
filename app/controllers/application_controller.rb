require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
   erb :index
  end

  get '/plants' do
    @user = User.find_by_id(session[:user_id])
    @plants = Plant.all
    erb :'/plants/plants'
  end

  get '/signup' do
   erb :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/plants'
      else
        redirect to '/signup'
      end
    end
  end

  get '/plants/new' do
    erb :'/plants/create_plant'
  end

  get '/admin' do
    @users = User.all
    erb :'/users/all_users'
  end

  get '/login' do
    if session.include?(:user_id)
      redirect '/plants'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
   user = User.find_by(username: params[:username], email: params[:email])
   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect '/plants'
   else
     redirect '/login'
   end
  end

  get '/logout' do
    if session.include?(:user_id)
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
  end

  post '/plants' do
    @plant = Plant.new(name: params[:name], )

  end

  get '/plants/:id' do
    @plant = Plant.find_by_id(params[:id])
    erb :'/plants/show_plant'
  end

end
