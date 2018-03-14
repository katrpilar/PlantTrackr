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
    # t.string :event
    # t.date :event_date
    # t.string :soil_status
    # t.string :leaf_status
    if params[:name] != ""
      @plant = Plant.create(name: params[:name], picture: params[:picture], sunlight: params[:sunlight], soil: params[:soil], container_size: params[:container], drainage: params[:drainage])
      @plant.user = User.find_by_id(session[:user_id])
      @plant.save
      @instruction = Instruction.create(water_amt: params[:water_amt], water_amt_unit: params[:water_amt_unit], water_freq: params[:water_freq], water_freq_unit: params[:water_freq_unit])
      @instruction.plant = @plant.id
      @status = Status.create(event: params[:event], event_date: params[:event_date], soil_status: params[:soil_status], leaf_status: params[:leaf_status])
      @status.plant = @plant.id
      redirect to :"/plants/#{@plant.id}"
    else
      redirect to :'/plants/new'
    end
  end

  get '/plants/:id' do
    @plant = Plant.find_by_id(params[:id])
    erb :'/plants/show_plant'
  end

end
