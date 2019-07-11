# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @resource, @id = request.path.split("/")[1, 2]
    @comment = Comment.new(body: params[:comment],
      commentable_type: @resource,
      commentable_id: @id,
      user_id: current_user.id
    )

    respond_to do |format|
      if @comment.save!
        format.html { redirect_back fallback_location: @post, notice: t(".notice") }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_back fallback_location: @post, notice: t(".notice") }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: @comment, notice: t(".notice") }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
      @comment.user = User.find_by(id: @comment.user_id)
    end
end
