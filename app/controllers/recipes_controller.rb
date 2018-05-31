class RecipesController < ApplicationController

  def index
    if params[:user_id]
      @recipes = User.find(params[:user_id]).recipes
    else
      @recipes = Recipe.all
    end
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
    @recipe = Recipe.find(params[:id])
  end

end


private

def recipe_params
  params.require(:recipe).permit(:name, :instructions)
end
