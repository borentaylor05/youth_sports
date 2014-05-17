class AddCoedToSports < ActiveRecord::Migration
  def change
    add_column :sports, :coed, :boolean
  end
end
