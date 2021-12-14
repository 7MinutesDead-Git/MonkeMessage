# frozen_string_literal: true

# Application controller for Users. Creating new users requires a User instance
# with :username, :email and :password attributes.
class UsersController < ApplicationController
  # https://github.com/rubocop/ruby-style-guide#i
  before_action(:set_user, only: %i[update edit show destroy])
  before_action(:require_user, only: %i[edit update destroy])
  before_action(:require_same_user, only: %i[edit update destroy])
  before_action(:set_max_pagy_items, only: %i[show index])

  # ------------------------ ------------------------
  def index
    # Paginate all users for performance and infinite scrolling.
    @pagy, @users = pagy(User.all, items: @max_pagy_items)
  rescue Pagy::OverflowError
    # If the user tries to directly access a pagination index that doesn't exist anymore
    # via URL or old link.
    redirect_to users_path
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
  def edit; end

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

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:danger] = 'Account has been deleted.'
    redirect_to root_path
  end

  # ------------------------ ------------------------
  private

  # ------------------------
  # The user_params required and permitted for creating a new user/account.
  # This will require a :user instance, with :username, :email and :password as attributes.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  # ------------------------
  def set_user
    # Locates user by :id from Users table.
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "That user doesn't exist."
    redirect_to root_path
  end

  # ------------------------
  def require_same_user
    return unless current_user != @user

    flash[:alert] = "This isn't your profile to edit, Monke."
    redirect_to @user
  end
end
