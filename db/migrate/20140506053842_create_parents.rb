class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :firstName
      t.string :lastName
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
