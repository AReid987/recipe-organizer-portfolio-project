class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :next_recipe]
  before_action :require_logged_in, except: [:index]

  def index
    if params[:user_id]
      @recipes = User.find(params[:user_id]).recipes
    else
      @recipes = Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to user_recipe_path(current_user, @recipe), notice: 'Recipe was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @comment = @recipe.comments.build

    #render :json => @recipe, include: ['items', 'items.ingredient']
  end

  def edit
    #@recipe = Recipe.find(params[:id])
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to user_recipe_path(current_user, @recipe), notice: 'Recipe was successfully updated.' }
      else
        format.html { render :edit, notice: 'Update unsuccessful' }
      end
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice:  "Recipe deleted."
  end

  def next_recipe
    @next_recipe = Recipe.find(@recipe.id + 1)
    render :json => @next_recipe, include: ['items', 'items.ingredient']
  end

private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :instructions,
      ingredients_attributes: [:id, :name, :_destroy, items_attributes: [:id, :quantity, :_destroy]]
    )
  end

  def ingredient_quantity
    items.first.quantity
  end

end
