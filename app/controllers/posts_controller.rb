class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :force_redirect_unless_my_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def new
    return redirect_to new_profile_path, alert: "you must make a profile!" if current_user.profile.blank?
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path, notice: '作成できました'
    else
      render :new, alert: '作成できませんでした'
    end
  end

  def update
    if @post.update(post_params)
      reidrect_to root_path, notice: '更新できました'
    else
      render :edit, alert: '更新できませんでした'
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path, notice: '削除に成功しました'
    else
      redirect_to root_path, alert: '削除できませんでした'
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :content, images: []
    )
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def force_redirect_unless_my_post
    return redirect_to root_path, alert: "It's not your post" if @post.user != current_user
  end

end