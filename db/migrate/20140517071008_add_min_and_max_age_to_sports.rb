class AddMinAndMaxAgeToSports < ActiveRecord::Migration
  def change
    add_column :sports, :min_age, :integer
    add_column :sports, :max_age, :integer
  end
end
