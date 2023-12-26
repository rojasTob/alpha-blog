class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created"
      redirect_to @category
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end