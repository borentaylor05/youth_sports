class AddCoachFor < ActiveRecord::Migration
  def change
  	add_column :parents, :coach_for, :string
  end
end
