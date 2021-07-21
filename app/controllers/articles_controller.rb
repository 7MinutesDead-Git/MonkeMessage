# Adding methods here means rails will expect matching erb files in views/articles.
# @variable is just a parameter/instance variable of the class.
# same as marking something self.variable in Python.

# Controller for our Article actions.
class ArticlesController < ApplicationController
  # Returns matching Article with the requested :id.
  def show()
    @article = Article.find(params[:id])
  end

  # Show articles index (overview of articles).
  def index()
    @articles = Article.all
  end
end