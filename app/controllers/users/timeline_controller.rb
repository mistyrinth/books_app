# frozen_string_literal: true

class Users::TimelineController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @users = @user.followings

    book_posts = Book.where(user_id: @users.ids)
    report_posts = Report.where(user_id: @users.ids)
    comment_posts = Comment.where(user_id: @users.ids)
    @posts = (book_posts + report_posts + comment_posts).sort_by { |t|
      t[:updated_at]
    }.reverse!
    @count = @posts.count
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)

    render "show_timeline"
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
