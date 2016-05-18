class ArticlesController < ApplicationController
  before_action :move_to_index, except: :index
  require 'open-uri'
  OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
  OpenURI::Buffer.const_set 'StringMax', 0
  def new
    @article = Article.new
  end
  def index
    @articles = Article.includes(:user).all
    @article = Article.find_by(id: params[:id])
    @likes = Like.where(article_id: params[:id])
  end
  def show
    @article = Article.find(params[:id])
    @talks = @article.talks.includes(:user)
  end
  def create
    article = Article.create(image: article_params[:image], category: article_params[:category], comment: article_params[:comment], user_id: current_user.id, twittercheck: article_params[:twittercheck])

    # twitter 同時投稿
    if current_user.uid && article.twittercheck == 1
      client = Twitter::REST::Client.new do |config|
        config.consumer_key         = ENV['TWITTER_KEY']
        config.consumer_secret      = ENV['TWITTER_SECRET']
        config.access_token         = current_user.token
        config.access_token_secret  = current_user.secret
      end
      status = "ROOMEEに【#{article.category}】の写真を登録しました！「#{article.comment}」"
      media_url = "#{article.image.url}"
      media = open(media_url)
      client.update_with_media(status, media)
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article.user_id == current_user.id
      article.destroy
    end
  end
  def edit
    @article = Article.find(params[:id])
  end
  def update
    article = Article.find(params[:id])
    if article.user_id == current_user.id
      article.update(article_params)
    end
  end

  private
  def article_params
    params.require(:article).permit(:name, :image, :category, :comment, :twittercheck)
  end
  def move_to_index
      redirect_to action: :index unless user_signed_in?
  end
end
