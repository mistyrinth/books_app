module BooksHelper

  def comments_count(type, id)
    Comment.where(commentable_type: type, commentable_id: id ).count
  end

end
