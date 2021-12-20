class MonkeyTypesController < ApplicationController
  # ----------------------
  def new
    @monkey_type = MonkeyType.new
  end

  # ----------------------
  def show
  end

  # ----------------------
  def index
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
end
