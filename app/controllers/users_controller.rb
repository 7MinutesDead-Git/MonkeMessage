# Application controller for Users. Creating new users requires a User instance
# with :username, :email and :password attributes.
class UsersController < ApplicationController
  # ------------------------
  def index
    # Paginate all users for performance and infinite scrolling.
    @pagy, @users = pagy(User.all, items: 10)
  end

  # ------------------------
  def new
    @user = User.new
  end

  # ------------------------
  # Shows the profile for the user, and their articles/messages.
  def show
    @user = User.find(params[:id])
    @pagy, @articles = pagy(@user.articles.order('created_at DESC'), items: 10)
  end

  # ------------------------
  # User creating a new account.
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Successfully created account!'
      redirect_to(user_path)
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
      flash[:notice] = 'Profile successfully updated.'
      redirect_to(user_path)
    else
      render('edit')
    end
  end

  # ------------------------
  private

  # The user_params required and permitted for creating a new user/account.
  # This will require a :user instance, with :username, :email and :password as attributes.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end