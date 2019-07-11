# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follows, :followers, :timeline]

  def index
    @users = User.page(params[:page]).per(5)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path, notice: t(".notice") }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: t(".notice") }
      format.json { head :no_content }
    end
  end

  def follows
    @users = @user.followings
    render "show_follow"
  end

  def followers
    @users = @user.followers
    render "show_follower"
  end

  def timeline
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
    def user_params
      params.require(:user).permit(:name, :image)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
