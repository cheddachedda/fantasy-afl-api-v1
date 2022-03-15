# TODO: Fetch settings from League model``
$LEAGUE_SETTINGS = {
  teams: 10,
  starter_spots: {
    'DEF' => 2,
    'MID' => 3,
    'RUC' => 1,
    'FWD' => 2
  }
}

class Gamelog < ApplicationRecord
  @@pars = {}
  @@eligible_rounds_for_par = {}

  def self.calculate_all_pars
    years = Fixture.find_by_sql('SELECT DISTINCT year FROM fixtures ORDER BY year;').collect(&:year)

    years.to_h do |year|
      positions = ['DEF', 'MID', 'RUC', 'FWD']
      
      sql = "SELECT DISTINCT round_no FROM fixtures WHERE year=#{year} ORDER BY round_no;"
      rounds = Fixture.find_by_sql(sql).collect(&:round_no)

      by_position = positions.to_h do |pos|
                      par_scores =  rounds.to_h do |round_no|
                                      [round_no, Gamelog.calculate_par(year, pos, round_no)]
                                    end

                      [pos, par_scores]
                    end

      [year, by_position]
    end
  end

  def self.calculate_par(year, position, round_no)
    Gamelog.calculate_eligible_rounds if @@eligible_rounds_for_par.empty?

    par_score = nil
    
    if @@eligible_rounds_for_par[year] && @@eligible_rounds_for_par[year].include?(round_no)
      # TODO: Fetch settings from League model
      index = $LEAGUE_SETTINGS[:starter_spots][position] * $LEAGUE_SETTINGS[:teams]

      sql = "SELECT fantasy_score FROM gamelogs "\
            "WHERE round_no=#{round_no} "\
            "AND year=#{year} "\
            "AND '#{position}' = ANY (position) "\
            "ORDER BY fantasy_score DESC "\
            "LIMIT #{index};"
      
      par_score = Gamelog.find_by_sql(sql).last.fantasy_score
    else
      par_score = Gamelog.find_average_par(year, position, round_no)
    end

    Gamelog.add_par(par_score, year, position, round_no)
  end

  def self.find_average_par(year, position, round_no)
    averages =  (1..round_no - 1).each.map do |round|
                  @@pars[year][position][round]
                end

    par_score = averages.sum.to_f / averages.size
  end

  def self.add_par(score, year, position, round_no) 
    @@pars[year] = {} if @@pars.empty? ||  @@pars[year].nil?
    @@pars[year][position] = {} if @@pars[year].empty? || @@pars[year][position].nil?
    @@pars[year][position][round_no] = score
  end

  def self.calculate_eligible_rounds
    sql = 'SELECT COUNT(*), round_no, year '\
          'FROM gamelogs '\
          'GROUP BY round_no, year '\
          'HAVING COUNT(*) >= 264 '\
          'ORDER BY year, round_no;'

    rounds = Gamelog.find_by_sql(sql)

    rounds.each do |r|
      if @@eligible_rounds_for_par[r.year]
        @@eligible_rounds_for_par[r.year] << r.round_no
      else
        @@eligible_rounds_for_par[r.year] = [r.round_no]
      end
    end
  end

  def par
    Gamelog.calculate_all_pars if @@pars.empty?
    position.to_h do |pos|
      [pos, @@pars[year][pos][round_no]]
    end
  end

  def fantasy_value
    position.to_h do |pos|
      value = ((fantasy_score.to_f / par[pos]) * 100).round(2)
      [pos, value]
    end
  end
end
