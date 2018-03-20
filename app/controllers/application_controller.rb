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
    if logged_in?
      erb :'/plants/plants'
    else
      redirect :'/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/plants'
    else
      erb :'/users/create_user'
    end
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
    if logged_in?
      erb :'/plants/create_plant'
    else
      redirect :'/login'
    end
  end

  # get '/admin' do
  #   @users = User.all
  #   erb :'/users/all_users'
  # end

  get '/login' do
    if logged_in?
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
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
  end

  post '/plants' do
    if logged_in?
      @plant = Plant.create(name: params[:plant][:name], picture: params[:plant][:picture], sunlight: params[:plant][:sunlight], soil: params[:plant][:soil], container_size: params[:plant][:container], drainage: params[:plant][:drainage])
      @plant.user = User.find_by_id(session[:user_id])
      @plant.save
      @instruction = Instruction.create(water_amt: params[:plant][:instructions][:water_amt], water_amt_unit: params[:plant][:instructions][:water_amt_unit], water_freq: params[:plant][:instructions][:water_freq], water_freq_unit: params[:plant][:instructions][:water_freq_unit])
      @instruction.plant = @plant
      @instruction.save
      if params[:plant][:statuses][:event] != "" && params[:plant][:statuses][:event_date] != "" && params[:plant][:statuses][:soil_status] != "" && params[:plant][:statuses][:leaf_status] != ""
        @status = Status.create(event: params[:plant][:statuses][:event], event_date: params[:plant][:statuses][:event_date], soil_status: params[:plant][:statuses][:soil_status], leaf_status: params[:plant][:statuses][:leaf_status])
        @status.plant = @plant
        @status.save
      end
      if @plant.save
        redirect to :"/plants/#{@plant.id}"
      else
        redirect to :'/plants/new'
      end
    else
      redirect to '/login'
    end
  end

  post '/plants/:id/copy' do
    @oldplant = Plant.find_by_id(params[:id])
    @plant = @oldplant.dup
    @plant.user = User.find_by_id(session[:user_id])
    @plant.save
    @instruction = Instruction.find_by_id(@oldplant.instructions.last.id).dup
    @instruction.plant = @plant
    @instruction.save
    redirect "/plants/#{@plant.id}/edit"
  end

  get '/plants/:id' do
    @plant = Plant.find_by_id(params[:id])
    if @plant.user == current_user
      @all_statuses = @plant.statuses
      erb :'/plants/show_plant'
    else
      redirect :'/plants'
    end
  end

  get '/plants/:id/edit' do
    @plant = Plant.find_by_id(params[:id])
    if current_user == @plant.user
      erb :'/plants/edit_plant'
    else
      redirect :'/plants'
    end
  end

  delete '/plants/:id/delete' do
    @plant = Plant.find_by_id(params[:id])
    if current_user == @plant.user
      @plant.delete
      redirect to :'/plants'
    else
      redirect to :'/login'
    end
  end

  get '/greenhouse' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @plants = User.find_by_id(session[:user_id]).plants
      erb :'/users/my_plants'
    else
      redirect to :'/login'
    end
  end

  patch '/plants/:id' do
      @plant = Plant.find_by_id(params[:id])
      if current_user == @plant.user
        @plant.update(name: params[:plant][:name], picture: params[:plant][:picture], sunlight: params[:plant][:sunlight], soil: params[:plant][:soil], container_size: params[:plant][:container], drainage: params[:plant][:drainage])
        @plant.save
        if params[:plant][:instructions][:water_amt] != @plant.instructions.last.water_amt || params[:plant][:instructions][:water_amt_unit] != @plant.instructions.last.water_amt_unit || params[:plant][:instructions][:water_freq] != @plant.instructions.last.water_freq || params[:plant][:instructions][:water_freq_unit] != @plant.instructions.last.water_freq
          @instruction = Instruction.create(water_amt: params[:plant][:instructions][:water_amt], water_amt_unit: params[:plant][:instructions][:water_amt_unit], water_freq: params[:plant][:instructions][:water_freq], water_freq_unit: params[:plant][:instructions][:water_freq_unit])
          @instruction.plant = @plant
          @instruction.save
        end
        redirect to :"/plants/#{@plant.id}"
      else
        redirect to :'/plants'
      end
  end

  post '/:plant_id/statuses' do
    @plant = Plant.find_by_id(params[:plant_id])
    if current_user == @plant.user
      @status = Status.create(event: params[:plant][:statuses][:event], event_date: params[:plant][:statuses][:event_date], soil_status: params[:plant][:statuses][:soil_status], leaf_status: params[:plant][:statuses][:leaf_status])
      @status.plant = @plant
      @status.save
      redirect to :"/plants/#{@plant.id}"
    else
      redirect to :'/plants'
    end
  end


  delete '/plants/statuses/:stat_id/delete' do
    @status = Status.find_by_id(params[:stat_id])
    @plant = Plant.find_by_id(@status.plant_id)
    if current_user == @plant.user
      @status.delete
      redirect to :"/plants/#{@plant.id}"
    else
      redirect to :'/plants'
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
