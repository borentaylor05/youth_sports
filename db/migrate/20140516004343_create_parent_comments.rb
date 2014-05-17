class CreateParentComments < ActiveRecord::Migration
  def change
    create_table :parent_comments do |t|
      t.string :body
      t.integer :parent_id

      t.timestamps
    end
    add_index :parent_comments, [:parent_id, :created_at]
  end
end
