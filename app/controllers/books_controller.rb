# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :load_commentable

  def index
    @books = Book.page(params[:page]).per(5)
    @current_user = current_user
  end

  def new
    @book = Book.new
  end

  def show
    @comment = @book.comments.build
    @comments = Comment.where(commentable_type: "books", commentable_id: @book).order(created_at: :desc)
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: t(".notice") }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: t(".notice") }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: t(".notice") }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
      @book.user = User.find_by(id: @book.user_id)
    end

    def book_params
      params.require(:book).permit(
        :title,
        :memo,
        :author,
        :picture,
        :user_id
      )
    end

    def load_commentable
      @commentable = @book
    end
end
