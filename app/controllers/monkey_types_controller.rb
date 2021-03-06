class MonkeyTypesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :store_return_to_url, only: [:index]
  # ----------------------
  def new
    @monkey_type = MonkeyType.new
  end

  # ----------------------
  def show
    @monkey_type = find_monkey_by_id
  end

  # ----------------------
  def index
    set_max_pagy_items
    @pagy, @monkey_type = pagy(MonkeyType.all.order('name DESC'), items: 20)
  rescue Pagy::OverflowError
    redirect_to monkey_type_path
  end

  # ----------------------
  def create
    @monkey_type = MonkeyType.new(monkey_type_params)

    if @monkey_type.save
      flash[:notice] = "Added new Monke! [ #{@monkey_type.name} ]"
      redirect_to @monkey_type
    else
      render 'new'
    end
  end

  # ----------------------
  private

  def monkey_type_params
    params.require(:monkey_type).permit(
      :name,
      :scientific_name,
      :colloquial_name,
      :age,
      :friendliness)
  end

  # ----------------------
  # Find monkey type with given :id from RESTful request.
  # Returns nil if the monkey does not exist.
  # Redirects to last page when RecordNotFound.
  def find_monkey_by_id
    MonkeyType.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "That Monke doesn't exist! Unless.."
    redirect_to session[:return_to]
    nil
  end

  # ----------------------
  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "Only Monke Moderators can add new Monkes!"
      redirect_to monkey_types_path
    end

  end
end
