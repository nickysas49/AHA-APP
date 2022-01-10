require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'bcrypt'
require 'pry'

require_relative 'image.rb'

enable :sessions

def logged_in?()
  if session[:user_id]
    return true
  else 
    return false
  end
end

def current_user()
  sql = "select * from users where id = #{ session[:user_id] };"
  user = db_query(sql).first
  return OpenStruct.new(user)
end


get '/' do

  images = all_images()

  erb(:index, locals: { images: images })
end

get '/images/new' do
  redirect '/login' unless logged_in?

  erb(:new)
end

get '/images/:id' do
 
  image_id = params['id']

  image = db_query("select * from images where id = $1", [image_id]).first

  erb(:show, locals: { image: image })
end


post '/images' do
  redirect '/login' unless logged_in?

  create_image(params['name'], params['image_front'],  params['image_back'], params['image_top'], params['image_bottom'], params['image_left'], params['image_right'], current_user().id)
  
  redirect "/" 
end

delete '/images/:id' do
  delete_image(params['id'])
  redirect '/'
end

get '/images/:id/edit' do

  sql = "select * from images where id = $1;"
  image = db_query(sql, [params['id']]).first

  erb(:edit, locals: { image: image })
end

get '/images/:id/add' do

  sql = "select * from images where id = $1;"
  image = db_query(sql, [params['id']]).first

  erb(:add, locals: { image: image })
end
put '/images/:id' do
  
  update_image(
    params['name'],
    params['image_front'],
    params['image_back'],
    params['image_top'],
    params['image_bottom'],
    params['image_left'],
    params['image_right'],
    params['id']
  )

  redirect "/images/#{params['id']}"
end


get '/login' do
  erb :login
end

post '/session' do
  email = params["email"]
  password = params["password"]

  conn = PG.connect(dbname: 'aha_app')
  sql = "select * from users where email = '#{email}';"
  result = conn.exec(sql)
  conn.close

  if result.count > 0 && BCrypt::Password.new(result[0]['password_digest']).==(password)
  
    session[:user_id] = result[0]['id']

    redirect '/'
  else 
    erb :login
  end

end


delete '/session' do
  session[:user_id] = nil
  redirect "/login"
end


