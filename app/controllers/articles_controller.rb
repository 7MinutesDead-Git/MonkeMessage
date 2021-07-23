# frozen_string_literal: true
# Adding methods here means rails will expect matching erb files in views/articles.
# @variable is just a parameter/instance variable of the class.
# same as marking something self.variable in Python.
#
# To see what each route needs, check "rails routes --expanded".
# ---------------------------------------------------
#     # Save the newly submitted article to the db, then show next.
#     #       # show route:
#     #       # --[ Route 6 ]------------------------------
#     #       # Prefix            | article
#     #       # Verb              | GET
#     #       # URI               | /articles/:id(.:format)
#     #       # Controller#Action | articles#show
#     #
#     # extract article :id from @new_article (rails will do this here),
#     # and redirect to this article's path (found with rails routes --expanded).
#     # The path can just be article prefix from the route, with _path appended.
#     #
#     # redirect_to(article_path(@new_article))
#     #
#     # Or, more simply (later added for convenience):
#     # redirect_to(@new_article)

# ---------------------------------------------------
# Controller for our Article actions.
class ArticlesController < ApplicationController
  # ----------------
  # Returns matching Article with the requested :id.
  def show
    @article = find_article_by_id
  end

  # ----------------
  # Show articles index (overview of articles).
  def index
    @articles = Article.all
  end

  # ----------------
  def new
    # @new_article needs to be initialized here so that the
    # errors parameter exists on first load of new.html.erb.
    # This is because we won't have errors until we first try to submit a faulty article.
    @article = Article.new
  end

  # ----------------
  # # Find requested article to edit so we can use it in edit.erb page.
  # # We'll run "update" method from that page after submitting edits.
  def edit
    @article = find_article_by_id
  end

  # ----------------
  # Update existing article with submitted changes via edit.html.erb.
  def update
    @article = find_article_by_id
    # Update the article's given params (title and description).
    if @article.update(permitted_params)
      flash[:notice] = 'Article updated.'
      redirect_to(@article)
    else
      flash[:alert] = 'Article edit did not save!'
      render('edit')
    end
  end

  # ----------------
  # Create a new article and add it to the database.
  def create
    # A new Article object with the permitted title and description params.
    @article = Article.new(permitted_params)

    # Save new article to db. See notes at top.
    if @article.save
      flash[:notice] = 'Article created.'
      # Open a page showing the new article (redirects to :location param I think).
      redirect_to(@article)
    else
      # If it fails, render "new" template again.
      flash[:alert] = 'Article did not save.'
      render('new')
    end

  end

  # ----------------
  # Delete specified article and return to article index page.
  def destroy
    @article = find_article_by_id
    @article.destroy
    redirect_to(articles_path)
  end

  # ----------------
  private
  # ----------------
  # Strong Parameters!
  # https://api.rubyonrails.org/classes/ActionController/StrongParameters.html
  # For params coming from a request, require the top level key of "article",
  # and only allow title and description to come through.
  # This is an added security feature to prevent unwanted form submissions.
  # Gets permitted title and description parameters and returns the Parameters object.
  def permitted_params
    params.require(:article).permit(:title, :description)
  end

  # ----------------
  # Find Article with given :id from RESTful request. Return Article object.
  def find_article_by_id
    Article.find(params[:id])
  end

end
