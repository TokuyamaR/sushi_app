class PostCommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user

	def new
		@post_comment = PostComment.new
	end

	def create
		@post = Post.find(params[:post_id])
		@post_comment = PostComment.new(post_comment_params)
		@post_comment.user_id = current_user.id
		@post_comment.post_id = @post.id
		if @post_comment.save
			flash[:notice] = "コメントを投稿しました。"
			redirect_to post_path(@post_comment.post_id)
		else
			# @post = Post.find(params[:post_id])
			# @user = User.find(@post.user_id)
		     @post_comments = PostComment.where(post_id: @post.id).page(params[:page])
		    flash[:notice] = "コメントを入力してください"
			render "posts/show" 
		end
	end

	def index
	end

	def show
		@post_comment = PostComment.find(params[:post_id])
		@user = User.find(@post_comment.user_id)
	end

	def edit
	end

	def update
	end

	def destroy
		post_comment = PostComment.find(params[:id])
		post_comment.destroy
		flash[:notice] = "口コミを削除しました"
		redirect_to posts_path
	end

	private

	def post_comment_params
    params.require(:post_comment).permit(:title, :rating, :comment)
	end

end
