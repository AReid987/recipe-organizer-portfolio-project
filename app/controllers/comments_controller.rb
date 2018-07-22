class CommentsController < ApplicationController
  before_action :set_recipe

  def index
    @comments = @recipe.comments
    render :json => @comments
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.recipe = @recipe
    if @comment.save
      render :json => @comment
    else
      render 'recipes/show'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
