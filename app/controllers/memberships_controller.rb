# frozen_string_literal: true

class MembershipsController < ApplicationController
  def create
    @user = User.find(params[:membership][:following_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = Membership.find(params[:id]).following
    current_user.unfollow!(@user)
    redirect_to @user
  end
end
