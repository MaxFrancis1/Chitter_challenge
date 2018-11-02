require 'peep'

describe Peep do
  describe '#all' do
    it 'returns all peeps' do
      Peep.create(peep: "This is my first post to chitter", time: Time.now)
      Peep.create(peep: "This is my second post to chitter", time: Time.now)
      message = Peep.create(peep: "This is my third post to chitter", time: Time.now)

      messages = Peep.all

      expect(peeps.length).to eq 3
      expect(peeps.first).to be_a Peep
      expect(peeps.first.id).to eq peep.id
      expect(peeps.first.peep).to eq 'This is my third post to chitter'
    end
  end

  describe '#create' do
    it 'Adds a bookmark to our database' do
      peep = Peep.create(peep: "This is my first post to chitter", time: Time.now)
      persisted_data = PG.connect(dbname: 'Chitter_test').exec("SELECT * FROM peeps WHERE id = #{message.id};").to_a

      expect(peep).to be_a Peep
      expect(peep.id).to eq persisted_data.first['id']
      expect(peep.time).to eq Time.now.strftime("%H:%M:%S")
      expect(peep.peep).to eq "This is my first post to chitter"
    end
  end
end
