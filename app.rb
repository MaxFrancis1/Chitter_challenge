require 'sinatra/base'
require 'peep'

class ChitterChallenge < Sinatra::Base
  enable :method_override

  get '/' do
    @peep = Peep.all
    erb :index
  end

  get '/peep' do
    erb :message
  end

  post '/peep' do
    Peep.create(peep: params[:peep], time: Time.now)
    redirect '/'
  end

  get '/login' do
    erb :login
  end

  get '/home' do
    erb :home
  end

  get '/fail' do
    erb :fail
  end

  post '/login/sign_up' do
    User.sign_up(su_user_name: params[:su_user_name], su_password: params[:su_password], su_email: params[:su_email])
    redirect '/login'
  end

  post '/login/sign_in' do
    result = User.sign_in(li_user_name: params[:li_user_name], li_password: params[:li_password])
    if result == true
      redirect '/home'
    elsif result == false
      redirect '/fail'
    end
  end

  get 'peep/new' do
    erb :'peep/new'
  end

  run! if app_file == $0
end
