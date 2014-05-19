class AddCoachToParents < ActiveRecord::Migration
  def change
  	add_column :parents, :coach, :boolean
  end
end
