class AddImageUrlToTeam < ActiveRecord::Migration
  def change
  	add_column :teams, :image_url, :string
  end
end
