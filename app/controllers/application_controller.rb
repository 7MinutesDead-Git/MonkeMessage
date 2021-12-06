class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Declaring something as a helper method allows these methods to be served to views as well as controllers.
  helper_method(:current_user, :logged_in?)

  def current_user
    # Assigns the database query to @current_user, unless it already exists. "Or" assignment.
    # This is so we don't repeatedly query the db if we don't need to.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # Two bangs in rails turns the object into a boolean,
    # so we can simply confirm that current_user exists
    # to verify they are logged in.
    !!current_user
  end
end
