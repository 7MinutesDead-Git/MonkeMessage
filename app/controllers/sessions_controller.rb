# https://guides.rubyonrails.org/security.html
class SessionsController < ApplicationController
  def new
  end

  def create
    # Login form from login page will submit email/password as params[:session].
    user = User.find_by(email: params[:session][:email].downcase)

    # If that user exists, and the correct password was supplied..
    if user&.authenticate(params[:session][:password])
      # https://guides.rubyonrails.org/action_controller_overview.html#session
      # Here we store the id in a session cookie, which is encrypted and cryptographically signed.
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully.'
      redirect_to(user)
    else
      # Since we are not redirecting (doing another full http request cycle),
      # the flash alert must happen "now". We are only re-rendering the page.
      flash.now[:alert] = 'Login info was incorrect.'
      render('sessions/new')
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out successfully.'
    redirect_to(root_path)
  end

end