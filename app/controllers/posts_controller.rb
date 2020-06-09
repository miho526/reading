class PostsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @posts = Posts.find_by(book_id: params[:book_id])
  end
  
  def new
    @post = current_user.posts.build
    @book = Book.find(params[:book_id])
  end
  
  def create
    @post = current_user.posts.build(post_params)
    @post.book_id = params[:book_id]
    @book = Book.find(params[:book_id])
    if @post.save
      current_user.posted(@book)
      flash[:success] = 'レビューを投稿しました。'
      redirect_to my_posts_user_path(current_user)
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
    @post = current_user.posts.find(params[:post_id])
    params[:book_id] = @post.book_id
    @book = Book.find(params[:book_id])
  end
  
  def update
    @post = current_user.posts.find(params[:post_id])
    params[:book_id] = @post.book_id
    @book = Book.find(params[:book_id])
    if @post.update(post_params)
      current_user.posted(@book)
      flash[:success] = 'レビューを投稿しました。'
      redirect_to my_posts_user_path(current_user)
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @post = current_user.posts.find(params[:post_id])
    current_user.unpost(@post)
    @post.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def post_params
    params.require(:post).permit(:content)
  end
  
end