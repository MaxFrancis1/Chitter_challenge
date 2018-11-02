require 'pg'

class Peep
  attr_reader :id, :peep, :time

  def initialize(id:, peep:, time:)
    @id = id
    @peep = peep
    @time = time
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect( dbname: 'Chitter_test' )
    else
      conn = PG.connect( dbname: 'Chitter')
    end
    conn.exec( 'SELECT * FROM peeps' ).map { |peep| Peep.new(id: peep['id'], peep: peep['peep'], time: peep['time'])}.reverse
  end

  def self.create(peep:, time:)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect( dbname: 'Chitter_test' )
    else
      conn = PG.connect( dbname: 'Chitter')
    end
    peep = conn.exec( "INSERT INTO peep (peep, time) VALUES('#{peep}', '#{time}') RETURNING id, peep, time;")
    Peep.new(id: peep[0]['id'], peep: peep[0]['peep'], time: peep[0]['time'])
  end
end
