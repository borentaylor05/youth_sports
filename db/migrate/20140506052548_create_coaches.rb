class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.integer :phone

      t.timestamps
    end
  end
end
