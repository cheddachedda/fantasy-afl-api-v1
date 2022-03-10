@clubs = [
  { :name=>'Adelaide', :moniker=>'Crows', :abbreviation=>'ADE' },
  { :name=>'Brisbane', :moniker=>'Lions', :abbreviation=>'BRL' },
  { :name=>'Carlton', :moniker=>'Blues', :abbreviation=>'CAR' },
  { :name=>'Collingwood', :moniker=>'Magpies', :abbreviation=>'COL' },
  { :name=>'Essendon', :moniker=>'Bombers', :abbreviation=>'ESS' },
  { :name=>'Fremantle', :moniker=>'Dockers', :abbreviation=>'FRE' },
  { :name=>'Geelong', :moniker=>'Cats', :abbreviation=>'GEE' },
  { :name=>'Gold Coast', :moniker=>'Suns', :abbreviation=>'GCS' },
  { :name=>'Greater Western Sydney', :moniker=>'Giants', :abbreviation=>'GWS' },
  { :name=>'Hawthorn', :moniker=>'Hawks', :abbreviation=>'HAW' },
  { :name=>'Melbourne', :moniker=>'Demons', :abbreviation=>'MEL' },
  { :name=>'North Melbourne', :moniker=>'Kangaroos', :abbreviation=>'NTH' },
  { :name=>'Port Adelaide', :moniker=>'Power', :abbreviation=>'PTA' },
  { :name=>'Richmond', :moniker=>'Tiger', :abbreviation=>'RIC' },
  { :name=>'St Kilda', :moniker=>'Saints', :abbreviation=>'STK' },
  { :name=>'Sydney', :moniker=>'Swans', :abbreviation=>'SYD' },
  { :name=>'West Coast', :moniker=>'Eagles', :abbreviation=>'WCE' },
  { :name=>'Western Bulldogs', :moniker=>'Bulldogs', :abbreviation=>'WBD' }
]

def seed_clubs
  @clubs.each do |club|
    Club.create(club)
    puts "Created club: #{ club[:name] }"
  end
end