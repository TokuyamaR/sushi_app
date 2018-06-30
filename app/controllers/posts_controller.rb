class PostsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :ensure_correct_user, only:[:edit, :update, :destroy]


  def top
    @user = User.find(current_user.id)
  end

  def index
    	@posts = Post.search(params[:search]).page(params[:page]).reverse_order
      if @posts.count == 0
        if  user_signed_in?
          flash[:notice] = "該当する店舗はありません"
          @user = User.find(current_user.id)
          redirect_to post_top_path
        else
          flash[:notice] = "該当する店舗はありません"
          redirect_to root_path
        end
      end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to post_path(@post.id)
    else
      render "posts/new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @post_comment = PostComment.new
    @post_comments = PostComment.where(post_id: @post.id).page(params[:page]).reverse_order
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '投稿内容を更新しました'
      redirect_to posts_path(@post.id)
    else
      @post = Post.find(@post.id)
      render "posts/edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to post_top_path
  end

  private

  def post_params
    params.require(:post).permit(:store, :post_image_name, :station, :url, :user_id)
  end
end
