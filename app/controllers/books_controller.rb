class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page])
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    @books = if params[:category_id].present?
               Book.where('title LIKE ? AND category_id = ?', "%#{params[:query]}%", params[:category_id])
             else
               Book.where('title LIKE ?', "%#{params[:query]}%")
             end.page(params[:page])
    render :index
  end
end
