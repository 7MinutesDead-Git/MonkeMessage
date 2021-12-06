# Application controller for Users. Creating new users requires a User instance
# with :username, :email and :password attributes.
class UsersController < ApplicationController
  # ------------------------ ------------------------
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
    set_user
    @pagy, @articles = pagy(@user.articles.order('created_at DESC'), items: 10)
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
    set_user
  end

  # ------------------------
  # User updating their profile.
  def update
    set_user
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
    # Calling this method can also be achieved with
    #   before_action(:set_user, only: [:show, :edit, :update])
    # and then removing the calls from those other methods,
    # but I'm still debating which I find more readable.
    #
    # Locates user by :id from Users table.
    @user = User.find(params[:id])
  end
end