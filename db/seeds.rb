require_relative './seed_files/clubs'

start_time = Time.new

seed_clubs

end_time = Time.new
run_time = (end_time - start_time).round

puts "Seeded in #{ run_time } seconds"