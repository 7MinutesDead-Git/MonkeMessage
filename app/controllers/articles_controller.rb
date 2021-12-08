# frozen_string_literal: true

# Personal Notes:
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
# Controller for Article (messages) actions.
class ArticlesController < ApplicationController
  # https://github.com/rubocop/ruby-style-guide#i
  before_action(:require_user, except: %i[show index])
  before_action(:set_max_description_length, only: [:index])
  before_action(:require_same_article_user, only: %i[edit update destroy])

  # ----------------
  # Returns matching Article with the requested :id.
  def show
    @article = find_article_by_id
  end

  # ----------------
  # Show articles index (overview of articles).
  def index
    set_max_pagy_items
    # Paginate all articles for performance and infinite scrolling.
    @pagy, @articles = pagy(Article.all.order('created_at DESC'), items: 10)
  rescue Pagy::OverflowError
    # If the user tries to directly access a pagination index that doesn't exist anymore
    # via URL or old link.
    redirect_to articles_path
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
    Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "That message doesn't exist; At least not anymore."
    redirect_to articles_path
    nil
  end

  def require_same_article_user
    @article = find_article_by_id
    return unless @article && current_user != @article.user

    flash[:alert] = "This isn't your message to edit! Are you logged into the right account?"
    redirect_to @article
  end

  def set_max_description_length
    @max_description_length = 100
  end
end
