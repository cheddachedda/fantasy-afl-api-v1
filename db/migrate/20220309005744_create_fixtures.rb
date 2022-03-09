class CreateFixtures < ActiveRecord::Migration[7.0]
  def change
    create_table :fixtures do |t|
      t.integer :round_no,
      t.datetime :datetime,
      t.string :venue,
      t.integer :home_id,
      t.integer :away_id,
      t.integer :home_goals_qt,
      t.integer :home_behinds_qt,
      t.integer :home_goals_ht,
      t.integer :home_behinds_ht,
      t.integer :home_goals_3qt,
      t.integer :home_behinds_3qt,
      t.integer :home_goals_ft,
      t.integer :home_behinds_ft,
      t.integer :away_goals_qt,
      t.integer :away_behinds_qt,
      t.integer :away_goals_ht,
      t.integer :away_behinds_ht,
      t.integer :away_goals_3qt,
      t.integer :away_behinds_3qt,
      t.integer :away_goals_ft,
      t.integer :away_behinds_ft
    end
  end
end
