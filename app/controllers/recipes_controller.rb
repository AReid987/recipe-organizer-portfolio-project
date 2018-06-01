class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
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
  end

  def create
    byebug
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

  def edit
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params.reject{|k,v| v.blank?})
        format.html { redirect_to @recipe, notice: 'User was successfully updated.' }
      else
        format.html { render :edit, notice: 'Update unsuccessful' }
      end
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice:  "Recipe deleted."
  end

private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :instructions,
      ingredients_attributes: [:name, :id, :_destroy]
      #items_attributes: [:quantity]

    )
  end

end
