# frozen_string_literal: true

class CreateFollowRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_relations do |t|
      t.integer :follower_id
      t.integer :following_id
      t.timestamps
    end

    add_index :follow_relations, :follower_id
    add_index :follow_relations, :following_id
    add_index :follow_relations, [:follower_id, :following_id], unique: true
  end
end
