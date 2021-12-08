# frozen_string_literal: true

# Parent class for Articles, Pages, Users, Sessions, etc.
class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Personal Notes: Declaring something as a helper method allows
  #   these methods to be served to views as well as controllers.
  helper_method(:current_user, :logged_in?, :set_max_pagy_items, :store_return_to_url)

  # -----------------
  def current_user
    # Assigns the database query to @current_user, unless it already exists. "Or" assignment.
    # This is so we don't repeatedly query the db if we don't need to.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # -----------------
  def logged_in?
    # Personal Notes:
    # Two bangs in rails turns the object into a boolean,
    # so we can simply confirm that current_user exists
    # to verify they are logged in.
    !!current_user
  end

  # -----------------
  def require_user
    return if logged_in?

    store_return_to_url
    flash[:alert] = 'Monkes must log in to do that.'
    redirect_to login_path
  end

  # -----------------
  def set_max_pagy_items
    @max_pagy_items = 10
  end

  # -----------------
  def store_return_to_url
    session[:return_to] = request.url
  end
end
