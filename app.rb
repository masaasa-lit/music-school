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

post '/answers' do
  Answer.create(
    name: params[:name],
    age: params[:age],
    gendar: params[:gendar],
    grade: params[:grade],
    email: params[:email],
    password: params[:password],
    date: params[:date],
    content: params[:content]
  )
  redirect '/'
end

get '/answers' do
  @answers =Answer.all
  erb :answers
end

helpers do
  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.crudentials && @auth.crudentials == ['changeme','changeme']
  end
end
