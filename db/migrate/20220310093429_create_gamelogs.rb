class CreateGamelogs < ActiveRecord::Migration[7.0]
  def change
    create_table :gamelogs do |t|
      t.integer :player_id
      t.integer :club_id
      t.integer :fixture_id
      t.integer :round_no
      t.integer :year
      t.string :position, :array => true, :default => []
      t.integer :time_on_ground_percentage
      t.integer :fantasy_score
    end
  end
end
