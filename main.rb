require 'sinatra'
require 'sinatra/reloader'
require 'pg' 
require 'bcrypt'
require 'pry'

def logged_in?()
  if session[:user_id]
    return true
  else 
    return false
  end
end

get '/' do
  conn = PG.connect(dbname: 'aha_app')
  sql = "SELECT * FROM images;"
  result = conn.exec(sql)

  conn.close
  
  erb :index, locals: { images: result}
end

get '/images/:id' do
  image_id = params['id']
  conn = PG.connect(dbname: 'aha_app')
  sql = "SELECT * FROM images where id = #{image_id};"
  result = conn.exec(sql)
  image = result[0]
  conn.close
  
  erb(:show, locals: { image: image})
end

get '/add_item' do
  erb(:new)
end

post '/input_item' do
  conn = PG.connect(dbname: 'aha_app')
  sql = "INSERT INTO 
  images (name, image_front, image_back, image_top, image_bottom, image_left, image_right) values('#{params['name']}','#{params['image_front']}','#{params['image_back']}','#{params['image_top']}','#{params['image_bottom']}','#{params['image_left']}','#{params['image_right']}');"
  conn.exec(sql)
  conn.close

  redirect "/"

end

get '/images/:id/edit' do
  conn = PG.connect(dbname: 'aha_app')
  sql = "SELECT * FROM images where id = #{image_id};"
  result = conn.exec(sql)
  image = result[0]
  conn.close
  erb(:edit, locals: { image: image})
  
end

delete '/images/:id' do
  delete_dish(params['id'])

  redirect '/'
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
