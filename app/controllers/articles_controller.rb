# Adding methods here means rails will expect matching erb files in views/articles.
# @variable is just a parameter/instance variable of the class.
# same as marking something self.variable in Python.
#
# To see what each route needs, check "rails routes --expanded".

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
    # A new Article object with the permitted title and description params.
    @new_article = Article.new(permitted_params)

    # Save the newly submitted article to the db.
    if @new_article.save
      # If it saved, show it next!
      #       # show route:
      #       # --[ Route 6 ]------------------------------
      #       # Prefix            | article
      #       # Verb              | GET
      #       # URI               | /articles/:id(.:format)
      #       # Controller#Action | articles#show
      #
      # extract article :id from @new_article (rails will do this here),
      # and redirect to this article's path (found with rails routes --expanded).
      # The path can just be article prefix from the route, with _path appended.
      #
      # redirect_to(article_path(@new_article))
      #
      # Or, more simply (later added for convenience):
      redirect_to(@new_article)
    end
  end

  # ----------------
  def new()

  end
end