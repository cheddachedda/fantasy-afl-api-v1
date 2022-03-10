def find_club_id(club_name)
  aliases = {
    'Brisbane Lions' => 'Brisbane',
    'GWS Giants' => 'Greater Western Sydney',
  }
  
  club_name = aliases[club_name] if aliases[club_name].present?

  Club.find_by(name: club_name).id
end

def parse_score(string)
  {
    :goals => string.split('.')[0].to_i,
    :behinds => string.split('.')[1].to_i
  }
end

def parse_venue(venue_name)
  aliases = {
    'AAMI Stadium' => 'Optus Stadium', # an error correction
    'Adelaide Oval' => 'Adelaide Oval',
    'Blundstone Arena' => 'Blundstone Arena',
    "Cazaly's Stadium" => "Cazaly's Stadium",
    'Eureka Stadium' => 'Mars Stadium',
    'Gabba' => 'Gabba',
    'Manuka Oval' => 'Manuka Oval',
    'Marvel Stadium' => 'Marvel Stadium',
    'Melbourne Cricket Ground' => 'MCG',
    'Metricon Stadium' => 'Metricon Stadium',
    'Optus Stadium' => 'Optus Stadium',
    'Simonds Stadium' => 'GMHBA Stadium',
    'Sydney Cricket Ground' => 'SCG',
    'Sydney Showground Stadium' => 'GIANTS Stadium',
    'University of Tasmania Stadium' => 'University of Tasmania Stadium'
  }

  aliases[venue_name]
end

def parse_datetime(string)
  dt = DateTime.parse(string)
  dst_end = DateTime.parse('04/04/2021 16:00')

  if (dt < dst_end)
    DateTime.parse("#{string} +11")
  else
    DateTime.parse("#{string} +10")
  end
end