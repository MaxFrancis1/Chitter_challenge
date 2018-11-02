require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'Chitter_test')

  connection.query("SELECT * FROM tweets WHERE id = #{id};")

end
