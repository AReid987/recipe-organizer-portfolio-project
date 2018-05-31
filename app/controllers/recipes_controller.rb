class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
  end

end


private

def recipe_params
  params.require(:recipe).permit(:name, :instructions)
end
