class CreateChildrenSportsJoinTable < ActiveRecord::Migration
  def change
  	create_table :children_sports, id: false do |t|
  		t.integer :child_id
  		t.integer :sport_id
  	end
  	add_index :children_sports, [:child_id, :sport_id]
  end
end
