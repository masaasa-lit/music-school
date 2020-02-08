require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require './models'
require 'sinatra'
require 'pony'

enable :sessions

get '/' do
  erb :index
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post 'signin' do
  user = User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get 'signout' do
  session[:user] = nil
  redirect '/'
end

post 'signup' do
  @user = User.create(mail:params[:mail], password:params[:password], password_confirmation:params[:password_confirmation])
  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

post '/form' do
  name = params[:name]
  email = params[:email]
  message = params[:message]

  Pony.mail(
    :from => "masaasa0429@icloud.com",
    :to => "59002asanuma@seiko.ac.jp",
    :body => message,
    :subject => "Hi"
  )
    redirect '/'
end