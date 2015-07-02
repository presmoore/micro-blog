require 'sinatra'
require 'sinatra/activerecord'
require './models.rb'

set :database, "sqlite3:psblog_redo.sqlite3"

set :sessions, true



def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
end

get "/" do
  @title = "Feed"
  if current_user 
    @all_posts = Post.all
    erb :home
  else
    redirect "/sign_in"
  end
end

get "/sign_in" do
  @title = "Sign In"
  erb :sign_in
end

post "/sign_in" do
  @user = User.where(username: params[:user][:username]).first

  if @user && @user.password == params[:user][:password]
    session[:user_id] = @user.id
    redirect "/"
  else
    redirect "/sign_in"
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





# SETTINGS PAGE

get "/settings" do
  @title = "Account Settings"
  erb :settings
end

post "/update_first" do
  @current_user = User.find(session[:user_id])
  @current_user.update_attributes(firstname: params[:user][:firstname])
  redirect "/settings"
end

post "/update_last" do
  @current_user = User.find(session[:user_id])
  @current_user.update_attributes(lastname: params[:user][:lastname])
  redirect "/settings"
end

post "/update_username" do
  @current_user = User.find(session[:user_id])
  @current_user.update_attributes(username: params[:user][:username])
  redirect "/settings"
end

post "/update_email" do
 @current_user = User.find(session[:user_id])
  @current_user.update_attributes(email: params[:user][:email])
  redirect "/settings"
end

post "/update_password" do
  @current_user = User.find(session[:user_id])
  confirm = params[:confirm_new_password]

  if confirm == params[:user][:new_password]
    @current_user.update_attributes(password: params[:user][:new_password])
    redirect "/settings"
  else
    "Your new password & confirmation did not match, try again"
  end
end


post "/delete" do
  @current_user = User.find(session[:user_id])
  @current_user.delete
  session[:user_id] = nil
  redirect "/"
end


# HOME PAGE


# Reference '/sign_up' User.create for Post.create (params)


post "/new_blog" do
  @current_user = User.find(session[:user_id])
  @current_user.username = params[:post][:username]
end





get "/profile" do
  @title = "Profile"
  erb :profile
end












































