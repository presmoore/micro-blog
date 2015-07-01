require 'sinatra'
require 'sinatra/activerecord'
require './models.rb'

set :database, "sqlite3:psblog.sqlite3"

set :sessions, true



def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
end




get "/" do
  if current_user 
    erb :home 
  else
    redirect "/sign_in"
  end
end

get "/sign_in" do
  erb :sign_in
end

post "/sign_in" do
  @user = User.where(username: params[:user][:username]).first

  if @user.password == params[:user][:password]
    session[:user_id] = @user.id
    redirect "/"
  else
    "Your username or password did not match"
  end
end

post "/sign_up" do
  confirmation = params[:confirm_password]

  if confirmation == params[:user][:password]
    @user = User.create(params[:user])
    redirect "/"
  else
    "Your password & confirmation did not match, try again"
  end
end



