class ArticlesController < ApplicationController
  before_action :move_to_index, except: :index
  def new
    @article = Article.new
  end
  def index
    @articles = Article.all
    @article = Article.all
  end
  def show
    @article = Article.find(params[:id])
    @talks = @article.talks.includes(:user)
  end
  def create
    Article.create(article_params)
  end

  private
  def article_params
    params.require(:article).permit(:name, :image, :category, :comment)
  end
  def move_to_index
      redirect_to action: :index unless user_signed_in?
  end
end
