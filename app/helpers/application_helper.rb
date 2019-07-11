# frozen_string_literal: true

module ApplicationHelper
  def attach_default_image
    current_user.image.attach(
      io: File.open("app/assets/images/default.png"),
      filename: "default.png",
      content_type: "image/png"
    )
  end

  def comments_count(type, id)
    Comment.where(commentable_type: type, commentable_id: id).count
  end

  def find_contributor(user_id)
    User.find_by(id: user_id).name
  end
end
