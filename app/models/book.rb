# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :comments, as: :commentable
  mount_uploader :picture, PictureUploader
  belongs_to :user
end
