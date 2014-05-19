class DropSportsChildren < ActiveRecord::Migration
  def change
  	drop_table :sports_children
  end
end
