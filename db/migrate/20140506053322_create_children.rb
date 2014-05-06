class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :firstName
      t.string :lastName
      t.date :birthday
      t.boolean :physicalComplete
      t.integer :parent

      t.timestamps
    end
  end
end
