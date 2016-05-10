class LikesController < ApplicationController
  def create
    @like = Like.create(user_id: current_user.id, article_id: params[:article_id])
    @likes = Like.where(article_id: params[:article_id])
    @articles = Article.all
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, article_id: params[:article_id])
    like.destroy
    @likes = Like.where(article_id: params[:article_id])
    @articles = Article.all
  end
end