# Application controller for Users. Creating new users requires a User instance
# with :username, :email and :password attributes.
class UsersController < ApplicationController
  # ------------------------
  def new
    @user = User.new
  end

  # ------------------------
  # User creating a new account.
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
  def edit
    # Locates user by :id from Users table.
    @user = User.find(params[:id])
  end

  # ------------------------
  # User updating their profile.
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Profile successfully updated."
      # TODO: This will redirect to the user profile page.
      redirect_to(articles_path)
    else
      render('edit')
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