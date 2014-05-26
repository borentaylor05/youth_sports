class AddUsernameToChildren < ActiveRecord::Migration
  def change
  	add_column :children, :username, :string
  end
end
