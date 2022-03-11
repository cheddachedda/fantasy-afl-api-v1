@edge_cases = {
  'Ellis-Yolmen' => 'https://afltables.com/afl/stats/players/C/Cam_Ellis-Yolmen.html',
  'Taberner' => 'https://afltables.com/afl/stats/players/M/Matthew_Taberner.html',
  'De Goey' => 'https://afltables.com/afl/stats/players/J/Jordan_de_Goey.html',
  'Hinge' => 'https://afltables.com/afl/stats/players/M/Mitch_Hinge.html',
  'Petty' => 'https://afltables.com/afl/stats/players/H/Harry_Petty.html'
}

def parse_round_no(row_text)
  finals = {
    'QF': 24,
    'EF': 24,
    'SF': 25,
    'PF': 26,
    'GF': 27
  }

  finals[row_text.to_sym].nil? ? row_text.to_i : finals[row_text.to_sym]
end

def find_fixture_id(club_id, round_no, year)
  sql =
    "SELECT id FROM fixtures "\
    "WHERE year=#{year} AND round_no=#{round_no} AND home_id=#{club_id} "\
    "OR year=#{year} AND round_no=#{round_no} AND away_id=#{club_id}"

  Fixture.find_by_sql(sql).to_a[0].id
end

def parse_stats(data)
  {
    :kicks => data[5],
    :marks => data[6],
    :handballs => data[7],
    :goals => data[9],
    :behinds => data[10],
    :hitouts => data[11],
    :tackles => data[12],
    :free_kicks_for => data[17],
    :free_kicks_against => data[18]
  }
end

def calculate_fantasy_score(stats)
  scoring = {
    :kicks => 3,
    :marks => 3,
    :handballs => 2,
    :goals => 6,
    :behinds => 1,
    :hitouts => 1,
    :tackles => 4,
    :free_kicks_for => 1,
    :free_kicks_against => -3
  }

  stats
    .map{ |category, n| n * scoring[category] }
    .sum
end