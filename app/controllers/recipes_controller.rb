class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_path(@recipe), notice: 'Recipe was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

end


private

def recipe_params
  params.require(:recipe).permit(:name, :instructions)
end
