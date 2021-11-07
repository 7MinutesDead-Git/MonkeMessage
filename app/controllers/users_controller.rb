# Application controller for Users. Creating new users requires a User instance
# with :username, :email and :password attributes.
class UsersController < ApplicationController
  # ------------------------
  def new
    @user = User.new
  end

  # ------------------------
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully created account!"
      # TODO: This will redirect to the new user page.
      #   Best case, it should redirect to a page that tells the user to check their email to confirm account.
      redirect_to(articles_path)
    else
      render('users/new')
    end
  end

  # ------------------------
  private

  # The user_params required and permitted for creating a new user/account.
  # This will require a :user instance, with :username, :email and :password as attributes.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end