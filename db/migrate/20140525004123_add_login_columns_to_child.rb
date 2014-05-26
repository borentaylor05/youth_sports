class AddLoginColumnsToChild < ActiveRecord::Migration
  def change
  	add_column :children, :password_digest, :string
  	add_column :children, :remember_token, :string
  	add_index :children, :remember_token
  end
end
