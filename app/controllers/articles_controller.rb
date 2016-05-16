class ArticlesController < ApplicationController
  before_action :move_to_index, except: :index
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
    article = Article.create(image: article_params[:image], category: article_params[:category], comment: article_params[:comment], user_id: current_user.id)
    if current_user.uid
      client = Twitter::REST::Client.new do |config|
        config.consumer_key         = "qLec7HB8jHsuxo0W1nsE0b10U"
        config.consumer_secret      = "oBXTdfcdicCsqDY0mThnNN0goowHC2JCAQzFYQ9sa5HG8nqtOm"
        config.access_token         = current_user.token
        config.access_token_secret  = current_user.secret
      end
      binding.pry
      client.update("ROOMEEに【#{article.category}】の写真を登録しました！「#{article.comment}」")
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
    params.require(:article).permit(:name, :image, :category, :comment)
  end
  def move_to_index
      redirect_to action: :index unless user_signed_in?
  end
end
