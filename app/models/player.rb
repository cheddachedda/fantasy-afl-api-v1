class Player < ApplicationRecord
  def average_fantasy_score
    scores = gamelogs
              .select{ |game| game[:time_on_ground_percentage] >= 25}
              .collect(&:fantasy_score)
    
    (scores.sum.to_f / scores.size).round(2)
  end

  def average_fantasy_value
    position.to_h do |pos|
      values = fantasy_values.map{ |round, values| values[pos] }
      average = values.empty? ? 0 : (values.sum / values.size).round(2)
      [pos, average]
    end
  end

  def club
    Club.find(club_id).as_json
  end
  
  def fantasy_scores
    gamelogs.to_h do |game|
      stats = {
        :fantasy_score => game.fantasy_score,
        :fantasy_value => game.fantasy_value,
        :rank => game.rank,
        :time_on_ground_percentage => game.time_on_ground_percentage,
      }

      [game.round_no, stats]
    end
  end

  def fantasy_values
    gamelogs.to_h do |game|
      [game.round_no, game.fantasy_value]
    end
  end

  def gamelogs
    Gamelog.where(player_id: id)
  end

  def to_json
    {
      **attributes.except('club_id'),
      'club' => club,
      'average_fantasy_score' => average_fantasy_score,
      'average_fantasy_value' => average_fantasy_value,
      'games' => fantasy_scores
    }
  end
end
