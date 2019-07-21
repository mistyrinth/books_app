# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.integer :follower_id
      t.integer :following_id
      t.timestamps
    end

    add_index :memberships, :follower_id
    add_index :memberships, :following_id
    add_index :memberships, [:follower_id, :following_id], unique: true
  end
end
