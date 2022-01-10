require 'pg'

def db_query(sql, params = [])
  conn = PG.connect(dbname: 'aha_app')
  result = conn.exec_params(sql, params) 
  conn.close
  return result
end

def all_images()
  db_query('select * from images order by name;')
end

def create_image(name, image_front, image_back, image_top, image_bottom, image_left, image_right, user_id)
  sql = "insert into images (name, image_front, image_back, image_top, image_bottom, image_left, image_right, user_id) values ($1, $2, $3, $4, $5, $6, $7, $8)"
  db_query(sql, [name, image_front, image_back, image_top, image_bottom, image_left, image_right, user_id])
end

def delete_image(id)
  db_query("delete from images where id = $1;", [id])
end

def update_image(name, image_front, image_back, image_top, image_bottom, image_left, image_right, id)
  sql = "update images set name = $1, image_front = $2, image_back = $3, image_top = $4, image_bottom = $5, image_left = $6, image_right = $7 where id = $8;"
  db_query(sql, [name, image_front, image_back, image_top, image_bottom, image_left, image_right, id])
end

def add_image(name, image_flq, image_blq, image_frq, image_q, image_left, image_right, id)
  sql = "update images set name = $1, image_flq = $9, image_blq = $10, image_frq = $11, image_brq = $12 where id = $8;"
  db_query(sql, [name, image_front, image_back, image_top, image_bottom, image_left, image_right, id])
end