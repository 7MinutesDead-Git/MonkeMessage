# frozen_string_literal: true

# https://guides.rubyonrails.org/security.html
# Controller for managing user sessions.
class SessionsController < ApplicationController
  # --------------------------
  def new; end

  # --------------------------
  def create
    user = find_user_by_email

    # If that user exists, and the correct password was supplied..
    if user&.authenticate(params[:session][:password])
      store_session_cookie
      redirect_user
    else
      rerender_on_failed_login
    end
  end

  # --------------------------
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out successfully.'
    redirect_to(root_path)
  end

  # -------------------------- --------------------------
  private

  # --------------------------
  def find_user_by_email
    # Login form from login page will submit email/password as params[:session].
    User.find_by(email: params[:session][:email].downcase)
  end

  # --------------------------
  def store_session_cookie
    # https://guides.rubyonrails.org/action_controller_overview.html#session
    # Here we store the id in a session cookie, which is encrypted and cryptographically signed.
    session[:user_id] = user.id
    flash[:notice] = 'Logged in successfully.'
  end

  # --------------------------
  def redirect_user
    if session[:return_to]
      # So the user can return to their previous attempted page when
      # redirected to login.
      redirect_to(session[:return_to])
    else
      redirect_to(user)
    end
  end

  # --------------------------
  def rerender_on_failed_login
    # Since we are not redirecting (doing another full http request cycle),
    # the flash alert must happen "now". We are only re-rendering the page.
    flash.now[:alert] = 'Login info was incorrect.'
    render('sessions/new')
  end
end
