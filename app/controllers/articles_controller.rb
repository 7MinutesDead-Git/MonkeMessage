# Personal Notes:
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
  before_action(:require_user, except: [:show, :index])
  before_action(:require_same_user, only: [:edit, :update, :destroy])
  # ----------------
  # Returns matching Article with the requested :id.
  def show
    @article = find_article_by_id
  end

  # ----------------
  # Show articles index (overview of articles).
  def index
    # Paginate all articles for performance and infinite scrolling.
    set_max_pagy_items
    @pagy, @articles = pagy(Article.all.order('created_at DESC'), items: 10)
  end

  # ----------------
  def new
    @article = Article.new
  end

  # ----------------
  # Find requested article to edit so we can use it in edit.erb page.
  def edit
    @article = find_article_by_id
  end

  # ----------------
  # Update existing article with submitted changes via edit.html.erb.
  def update
    @article = find_article_by_id

    if @article.update(permitted_params)
      flash[:notice] = 'Article updated.'
      redirect_to(@article)
    else
      flash[:alert] = 'Edit did not save!'
      render('edit')
    end
  end

  # ----------------
  # Create a new article and add it to the database.
  def create
    @article = Article.new(permitted_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = 'Article created.'
      redirect_to(@article)
    else
      flash[:alert] = 'Article did not save!'
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
  # Personal Notes: Strong Parameters!
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
  # Returns nil if the article does not exist.
  # Redirects to articles index when RecordNotFound.
  def find_article_by_id
    begin
      Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "That message doesn't exist; At least not anymore."
      redirect_to articles_path
      return nil
    end

  end

  def require_same_user
    @article = find_article_by_id
    if @article and current_user != @article.user
      flash[:alert] = "This isn't your message to edit! Are you logged into the right account?"
      redirect_to @article
    end
  end

end
