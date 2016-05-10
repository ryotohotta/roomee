class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @articles = user.articles
    @avatar = user.avatar
    @user = User.find(params[:id])
  end
  def likes
    @user = User.find(params[:id])
  end
end
