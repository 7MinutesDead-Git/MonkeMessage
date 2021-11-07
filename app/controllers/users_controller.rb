# TODO: Detail class documentation.
class UsersController < ApplicationController
  def new
    @user = User.new
  end
end