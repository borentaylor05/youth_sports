class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :coach
      t.integer :sport

      t.timestamps
    end
  end
end
