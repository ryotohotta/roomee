class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @articles = @user.articles
    @photo = @user.photo
    @likes = @user.likes
    @liked_articles = @user.liked_articles.uniq
  end
  def likes
    @user = User.find(params[:id])
  end
end