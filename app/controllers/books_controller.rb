class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :delete]

  # GET /books
  def index
    @books = Book.all
  end

  # GET /books/:id
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: "Book was successfully created."
    else
      render :new
    end
  end

  # GET /books/:id/edit
  def edit
  end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      redirect_to books_path, notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  # GET /books/:id/delete
  def delete
  end

  # DELETE /books/:id
  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully deleted."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title)
  end
end
