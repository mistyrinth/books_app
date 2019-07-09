class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commentable, polymorphic: true, index: true
      t.references :user, foreign_key: true
      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]
  end
end
