class ShelvesController < ApplicationController
  before_action :require_user_logged_in
  
  def read
    book = Book.find(params[:book_id])
    current_user.read(book)
    redirect_to my_books_user_path(current_user)
  end

  def create
    book = Book.find(params[:book_id])
    current_user.have(book)
    flash[:success] = '本棚に追加しました。'
    redirect_to my_books_user_path(current_user)
  end
  
  def destroy
    book = Book.find(params[:book_id])
    current_user.unhave(book)
    flash[:success] = '本棚から削除しました。'
    redirect_to my_books_user_path(current_user)
  end

end
