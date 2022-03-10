require_relative './seed_files/clubs.rb'
require_relative './seed_files/fixtures.rb'

Club.destroy_all
Fixture.destroy_all

start_time = Time.new

seed_clubs
seed_fixtures(2021)
seed_fixtures(2022)

end_time = Time.new
run_time = (end_time - start_time).round

puts "Seeded in #{ run_time } seconds"

# rails db:drop
# rails db:create
# rails db:migrate
# rails db:seed