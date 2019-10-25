class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :status_update, :destroy]

  def index
    @posts = Post.all
    @post  = Post.new 
  end

  def show
    @post  = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def status_update
    @post  = Post.find(params[:id])
    @post.recipient = current_user
    if @post.update(post_status_update)
      OfferMailer.offer_email(@post.provider, @post.recipient, @post).deliver
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @post = Post.new(post_params)
    @post.provider = current_user
    if @post.save
      flash.now[:notice] = '保存しました。'
      # redirect_back(fallback_location: root_path)
      redirect_to(post_path(@post.id))
    else
      @posts = Post.all
      flash.now[:alert] = '保存に失敗しました。入力が正しくありません。'
      render :index, posts: @posts
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    # 本人じゃなかったらルートパスにふぁっきん送り返す
    if not(authenticate_identity(@post))
      redirect_back(fallback_location: root_path) and return
    end

    if @post.update(post_params)
      redirect_to(post_path(@post.id))
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    # @postのproviderではない場合、削除させないようにする
    if not(authenticate_identity(@post))
      redirect_back(fallback_location: root_path) and return
    end

    if @post.destroy!
      redirect_to('/') and return
    else
      redirect_to('/') and return
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :lecture, :content, :condition, :image, :image_cache, :remove_image)
    end

    def post_status_update
      params.require(:post).permit(:status)
    end

    # postへの変更を本人しか行えないようにする
    def authenticate_identity(post)
      post.provider == current_user ? true : false
    end

    # 呼び出された関数のなかでredirectできなかったので、不採用
    # def authenticate_identity(a_post)
    #   if a_post.provider != current_user
    #     redirect_back(fallback_location: root_path) #and return
    #   end
    # end
end
