require 'pg'
require 'pry'


conn = PG.connect(dbname: 'goodfoodhunting')
sql = "SELECT * FROM dishes;"
result = conn.exec(sql)

result.each do |dish|
 puts "#{dish["id"]} - #{dish["name"]}"
end

conn.close