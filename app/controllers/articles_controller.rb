# Adding methods here means rails will expect matching erb files in views/articles.
# @variable is just a parameter/instance variable of the class.
# same as marking something self.variable in Python.

# ---------------------------------------------------
# Controller for our Article actions.
class ArticlesController < ApplicationController
  # ----------------
  # Returns matching Article with the requested :id.
  def show()
    @article = Article.find(params[:id])
  end

  # ----------------
  # Show articles index (overview of articles).
  def index()
    @articles = Article.all
  end

  # ----------------
  # How new articles are created/submitted.
  def create()
    # For params coming from a request, require the top level key of "article",
    # and only allow title and description to come through.
    # This is an added security feature to prevent unwanted form submissions.
    permitted_params = params.require(:article).permit(:title, :description)
    # Then make a new Article object with those permitted params.
    @new_article = Article.new(permitted_params)
    # Save the newly submitted article to the db.
    @new_article.save
  end

  # ----------------
  def new()

  end
end