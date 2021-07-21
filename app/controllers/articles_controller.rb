
class ArticlesController < ApplicationController
  # Returns matching Article with the requested :id.
  def show()
    @article = Article.find(params[:id])
  end
end