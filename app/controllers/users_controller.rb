class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @articles = user.articles
    @avatar = user.avatar
  end
end
