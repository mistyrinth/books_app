# frozen_string_literal: true

class Users::FollowFunctionController < ApplicationController
  before_action :set_user, only: [:follows, :followers]

  def follows
    @users = @user.followings
    render "show_follow"
  end

  def followers
    @users = @user.followers
    render "show_follower"
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
