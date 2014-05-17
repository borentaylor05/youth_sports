class AddIndexToComments < ActiveRecord::Migration
  def change
  	add_index :comments, [:parent_id, :created_at]
  end
end
