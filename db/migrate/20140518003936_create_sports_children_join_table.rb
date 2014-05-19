class CreateSportsChildrenJoinTable < ActiveRecord::Migration
  def change
  	create_table :sports_children, id: false do |t|
  		t.integer :child_id
  		t.integer :sport_id
  	end
  	add_index :sports_children, [:child_id, :sport_id]
  end
end
