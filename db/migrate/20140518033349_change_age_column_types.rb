class ChangeAgeColumnTypes < ActiveRecord::Migration
  def change
  	change_column :teams, :min_age, :integer
  	change_column :teams, :max_age, :integer
  end
end
