class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(provider: @user)
    @posts_bosyu = Post.where(provider: @user).where(status: "募集中")
    @posts_delivery = Post.where(provider: @user).where(status: "受け渡し中")
    @posts_done = Post.where(provider: @user).where(status: "受け渡し完了")
  end
end
