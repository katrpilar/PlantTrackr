require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "plantsarepowerful"
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
      @user = User.new(username: params[:username], email: params[:email], password_digest: params[:password])
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

  # post '/plants' do
  #   erb :'/plants'
  # end

end
