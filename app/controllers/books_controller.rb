class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page])
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    @books = Book.where('title LIKE ?', "%#{params[:query]}%")
  end
end