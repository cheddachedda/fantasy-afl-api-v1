class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :middle_initial
      t.string :last_name
      t.integer :club_id
      t.string :position, :array => true, :default => []
<<<<<<< HEAD
      t.integer :price
      t.datetime :dob
=======
>>>>>>> refs/remotes/origin/main
    end
  end
end
