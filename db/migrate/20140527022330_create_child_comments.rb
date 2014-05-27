class CreateChildComments < ActiveRecord::Migration
  def change
    create_table :child_comments do |t|
      t.string :body
      t.integer :child_id
      t.integer :parent_id
      t.integer :team_id

      t.timestamps
    end
  end
end
