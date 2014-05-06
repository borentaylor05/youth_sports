class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.date :season_start
      t.date :season_end
      t.string :open_to

      t.timestamps
    end
  end
end
