class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(provider: @user)

    # ユーザー詳細ページで表示するpostを取得。取得時にstatusごとにわけとかないといい感じに表示できなかった
    @posts_bosyu     = Post.where(provider: @user).where(status: "募集中")
    @posts_delivered = Post.where(provider: @user).where(status: "募集終了")
  end
end
