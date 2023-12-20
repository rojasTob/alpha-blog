class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new

  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description)) #this is the way to get the params because is not permited to take them directly from the params obj
    @article.save
    redirect_to article_path(@article) #shorten path is redirect_to @article
  end

end
