class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :coachID
      t.integer :parentID
      t.text :body
      t.boolean :announcement

      t.timestamps
    end
  end
end
