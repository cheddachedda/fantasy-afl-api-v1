class Player < ApplicationRecord
  def club
    Club.find(club_id)
  end

  def gamelogs
    gamelogs = Gamelog.where(player_id: id)
  end

  def fantasy_scores
    scores = {}

    gamelogs.each do |game|
      round = game[:round_no]
      score = game[:fantasy_score]
      scores[round] = score
    end

    scores
  end

  def average_fantasy_score
    scores = gamelogs
              .select{ |game| game[:time_on_ground_percentage] >= 25}
              .collect(&:fantasy_score)
    
    (scores.sum.to_f / scores.size).round(2)
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
