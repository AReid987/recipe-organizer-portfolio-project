class CommentsController < ApplicationController
  before_action :set_recipe

  def index
    @comments = @recipe.comments
    render :json => @comments
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
