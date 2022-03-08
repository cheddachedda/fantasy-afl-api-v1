start_time = Time.new

# Runs all seed files in db/seeds/ in alphabetical order of filenames
Dir[File.join(Rails.root, 'db', 'seed_files', '*.rb')].sort.each { |seed| load seed }

end_time = Time.new
run_time = (end_time - start_time).round

puts "Seeded in #{ run_time } seconds"