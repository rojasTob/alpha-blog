class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(articles_params) #this is the way to get the params because is not permited to take them directly from the params obj
    @article.user = User.first #Temporary solution
    if @article.save
      flash[:notice] = "Article was created successfully" # to create a kind of message to show in other page
      redirect_to article_path(@article) #shorten path is redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(articles_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to articles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private 
  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :description)
  end

end
