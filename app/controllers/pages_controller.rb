# Controller for page requests..
class PagesController < ApplicationController
  def home
    redirect_to(articles_path) if logged_in?
  end

  def about
  end

  def monke_gallery
  end

  def monke_replies
  end
end
