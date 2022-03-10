require 'csv'

def seed_players
  CSV.foreach('./db/seed_files/data/players.csv') do |line|    
    player = {
      :first_name => line[0],
      :middle_initial => line[1],
      :last_name => line[2],
      :club_id => Club.find_by(abbreviation: line[3]).id,
      :position => line[4].strip().split('/'),
      :price => line[5],
      :dob => DateTime.parse(line[6])
    }

    Player.create(player)
    puts "Created player: #{line[0..4].select{ |name| name }.join(' ')}"
  end
end