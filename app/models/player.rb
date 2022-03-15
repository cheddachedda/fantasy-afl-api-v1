class Player < ApplicationRecord
  def club
    Club.find(club_id)
  end

  def gamelogs
    gamelogs = Gamelog.where(player_id: id)
  end

  def fantasy_scores
    gamelogs.to_h do |game|
      [game.round_no, game.fantasy_score]
    end
  end

  def average_fantasy_score
    scores = gamelogs
              .select{ |game| game[:time_on_ground_percentage] >= 25}
              .collect(&:fantasy_score)
    
    (scores.sum.to_f / scores.size).round(2)
  end

  def fantasy_values
    gamelogs.to_h do |game|
      [game.round_no, game.fantasy_value]
    end
  end

  def average_fantasy_value
    position.to_h do |pos|
      values = fantasy_values.map{ |round, values| values[pos] }
      average = values.empty? ? 0 : (values.sum / values.size).round(2)
      [pos, average]
    end
  end

  def to_json
    {
      **attributes,
      :club => club,
      :average_fantasy_score => average_fantasy_score,
      :fantasy_scores => fantasy_scores
    }
  end
end
