require 'pg'
require 'bcrypt'

email = "niki1@niki.com"
password = "pudding"

conn =PG.connect(dbname:'aha_app')

password_digest = BCrypt::Password.create(password)

sql = "insert into users (email,password_digest) values ('#{email}','#{password_digest}');"

conn.exec(sql)
conn.close

puts "done"