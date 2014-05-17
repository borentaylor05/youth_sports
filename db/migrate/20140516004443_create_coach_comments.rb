class CreateCoachComments < ActiveRecord::Migration
  def change
    create_table :coach_comments do |t|
      t.string :body
      t.integer :coach_id
      t.boolean :announcement

      t.timestamps
    end
    add_index :coach_comments, [:coach_id, :created_at]
  end
end
