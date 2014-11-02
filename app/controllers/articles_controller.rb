class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def show
  end

  def create
    @user = User.find(current_user)
    @article = @user.articles.build(article_params)
    #@article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
  # def create
  #   @article = Article.find(params[:article_id])
  #   @comment = @article.comments.create(comment_params)
  #   redirect_to article_path(@article)
  # end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
