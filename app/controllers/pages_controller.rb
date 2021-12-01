class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_user, only: %i[show destroy]

  def index
    @users = User.all
  end

  def new
    @plan = Plan.new
  end

  # If user is in forms and selects to peruse plans he/she can start over again if a mistake was done
  def destroy
    @Plan.destroy
    redirect_to plans_path
  end

  private

  def user_params
    params.require(:user).permit(:price, :coverage_percent, :max_amount, :deductible)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
