require 'httparty'
require 'nokogiri'

require_relative './helpers/gamelogs'

# Recursive
def try_url(player, i=nil)
  url_params = [
    player[:first_name][0],
    player[:first_name],
    player[:last_name].gsub(' ', '_').gsub("'", ''),
    i
  ]

  url = @edge_cases[player[:last_name]] || "https://afltables.com/afl/stats/players/%c/%s_%s%s.html" % url_params
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML5(unparsed_page.body)

  broken_page = parsed_page.css('title').text == 'Broked!'
  dob_matches = i.nil?

  unless broken_page
    dob = parsed_page.text.split('Born:')[1].split(' ')[0]
    dob_matches = DateTime.parse(dob) == player[:dob]
  end

  # Base case
  return parsed_page if !broken_page && dob_matches
  return nil if url_params[3] == 2

  # Action
  i = i.nil? ? 0 : i + 1
  
  # Recursive case
  try_url(player, i)
end

def scrape_player_page(player)
  parsed_page = try_url(player)
  return if parsed_page.nil?

  club, year = parsed_page.css('.sortable thead').last.css('tr')[0].text.split(' - ')
  return if year.to_i != 2021

  rows = parsed_page.css('.sortable tbody').last.css('tr')
  rows.each do |row|
    data = row.css('td').collect(&:text)

    club_id = find_club_id(club)
    round_no = parse_round_no(data[2])
    fixture_id = find_fixture_id(club_id, round_no, year.to_i)

    stats = parse_stats(data.collect(&:to_i))
    fantasy_score = calculate_fantasy_score(stats)

    Gamelog.create({
      :player_id => player[:id],
      :club_id => club_id,
      :fixture_id => fixture_id,
      :round_no => round_no,
      :position => player[:position],
      :time_on_ground_percentage => data.last.to_i,
      :fantasy_score => fantasy_score
    })

    puts "Created gamelog: #{player[:first_name]} #{player[:last_name]} R#{round_no} #{fantasy_score}"
  end
end

def seed_gamelogs
  puts "Seeding gamelogs"

  Player.all.each do |player|
    scrape_player_page(player)
  end
end