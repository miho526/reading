class BooksController < ApplicationController
  require 'net/http'
  require 'json'
  require 'uri'
  
  def isbn
    params[:isbn]
    data = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    if @book.new_record?
      @book.title = data.title
      @book.author = data.author
      @book.isbn = data.isbn
      @book.price = data.item_price
      @book.image = data.large_image_url
      @book.url = data.item_url
      @book.save
    end
    redirect_to @book
  end
  
  def show
    @book = Book.find(params[:id])
    @book_posts = @book.posts.order(id: :desc).page(params[:page])
  end
  
end
