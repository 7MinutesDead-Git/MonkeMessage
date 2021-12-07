# Application controller for Users. Creating new users requires a User instance
# with :username, :email and :password attributes.
class UsersController < ApplicationController
  before_action(:set_user, only: [:update, :edit, :show])
  before_action(:require_user, only: [:edit, :update])
  before_action(:require_same_user, only: [:edit, :update])
  before_action(:set_max_pagy_items, only: [:show, :index])

  # ------------------------ ------------------------
  def index
    # Paginate all users for performance and infinite scrolling.
    @pagy, @users = pagy(User.all, items: @max_pagy_items)
  end

  # ------------------------
  def new
    @user = User.new
  end

  # ------------------------
  # Shows the profile for the user, and their articles/messages.
  def show
    @pagy, @articles = pagy(@user.articles.order('created_at DESC'), items: @max_pagy_items)
  end

  # ------------------------
  # User creating a new account.
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Successfully created account!'
      # Getting the user's session will log them in as soon as they sign up.
      session[:user_id] = @user.id
      redirect_to(articles_path)
    else
      render('users/new')
    end
  end

  # ------------------------
  def edit
  end

  # ------------------------
  # User updating their profile.
  def update
    if @user.update(user_params)
      flash[:notice] = 'Profile successfully updated.'
      redirect_to(user_path)
    else
      render('edit')
    end
  end

  # ------------------------ ------------------------
  private
  # ------------------------
  # The user_params required and permitted for creating a new user/account.
  # This will require a :user instance, with :username, :email and :password as attributes.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    # Locates user by :id from Users table.
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "This isn't your profile to edit, Monke."
      redirect_to @user
    end
  end
end