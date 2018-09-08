class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?


  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    	devise_parameter_sanitizer.permit(:update, keys: [:name,:introduction])
  	end

	def after_sign_in_path_for(resource)
	  	post_top_path
	end

	def after_sign_out_path_for(resource)
	  	root_path
	end

  def ensure_correct_user_for_users
      @user = User.find(params[:id])
      if current_user.id != @user.id
        flash[:notice] = "ログイン権限がありません"
        redirect_to post_top_path
      end
  end

	def ensure_correct_user_for_posts
      @post = Post.find(params[:id])
      @user = User.find(current_user.id)
      if @post.user_id != @user.id
        flash[:notice] = "ログイン権限がありません"
        redirect_to post_top_path
      end
  end

  def ensure_correct_user_for_postcomments
      @post = Post.find(params[:post_id])
      if current_user.id != @post.user_id
        flash[:notice] = "ログイン権限がありません"
        redirect_to post_top_path
      end
  end

  def forbid_login_user
      if current_user
        flash[:notice] = "すでにログインしています"
        redirect_to post_top_path
      end
  end
end
