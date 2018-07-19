class CommentsController < ApplicationController
  before_action :set_recipe

  def index
    @comments = @recipe.comments
    #@comment = @recipe.comments.build
    render :json => @comments
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
