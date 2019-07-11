# frozen_string_literal: true

class FollowRelationsController < ApplicationController
  def create
    @user = User.find(params[:follow_relation][:following_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = FollowRelation.find(params[:id]).following
    current_user.unfollow!(@user)
    redirect_to @user
  end
end
