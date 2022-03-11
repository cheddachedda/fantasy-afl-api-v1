require_relative './seed_files/clubs'
require_relative './seed_files/fixtures'
require_relative './seed_files/players'
require_relative './seed_files/gamelogs'

Club.destroy_all
Fixture.destroy_all
Player.destroy_all
Gamelog.destroy_all

start_time = Time.new

seed_clubs
seed_fixtures(2021)
seed_fixtures(2022)
seed_players
seed_gamelogs

end_time = Time.new
run_time = (end_time - start_time).round

puts "Seeded in #{ run_time } seconds"

# rails db:drop
# rails db:create
# rails db:migrate
# rails db:seed